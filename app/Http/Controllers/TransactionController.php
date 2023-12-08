<?php

namespace App\Http\Controllers;

use App\Helpers\FormatConverter;
use App\Models\Item;
use App\Models\ItemStock;
use App\Models\Transaction;
use App\Models\TransactionDetail;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Yajra\Datatables\Datatables;
use DB;
use Yajra\DataTables\Html\Builder;

class TransactionController extends Controller
{
    /**
     * Datatables Html Builder
     * @var Builder
     */
    protected $htmlBuilder;
    public function __construct(Builder $htmlBuilder) {
        $this->htmlBuilder = $htmlBuilder;
    }

    public function index(Request $request) {
        if ($request->ajax()) {
            $data = Transaction::select(['*'])->with(['customer']);
            $datatables = DataTables::of($data)
                ->addIndexColumn()
                ->addColumn('action', function($row){
                    $detail = route('transaction.show', ['transaction' => $row->id ]);
                    $print = route('transaction.print', ['transaction' => $row->id ]);
                    $deleteRoute = route('transaction.destroy', ['transaction' => $row->id ]);
                    $csrf = csrf_field(); $method = method_field('DELETE');
                    $btn = "<div class='d-flex'>
                                <a href='{$detail}' class='btn btn-sm btn-primary'>
                                    <i class='far fa-eye icon-nm'></i>
                                </a>&nbsp;
                                <a href='{$print}' class='btn btn-sm btn-success' target='_blank'>
                                    <i class='fa fa-print'></i>
                                </a>
                                <form method='POST' action='{$deleteRoute}'>{$csrf} {$method}
                                    <button class='btn btn-sm btn-danger' onclick=\"return confirm('Apakah Anda ingin menghapus data ini?')\"><i class='fa fa-trash icon-nm'></i>
                                    </button>
                                </form>
                            </div>";
                            
                            
                    return $btn;
                })
                ->editColumn('created_at', function($row) {
                    return Carbon::parse($row->created_at)->toDateTimeString();
                })
                ->editColumn('updated_at', function($row) {
                    return Carbon::parse($row->updated_at)->toDateTimeString();
                })
                ->editColumn('grand_total', function($row) {
                    return FormatConverter::rupiahFormat($row->grand_total);
                })
            //    ->editColumn('user', function($row) {
            //        return $row->user ? $row->user->name : '-';
            //    })
            //    ->editColumn('customer', function($row) {
            //        return $row->customer ? $row->customer->name : '-';
            //    })
                ->rawColumns(['action']);
            return $datatables->make(true);
        }

        $dataTable = $this->htmlBuilder
            ->parameters([
                'paging' => true,
                'searching' => true,
                'info' => false,
                'searchDelay' => 350,
                'buttons' => ['pdf'],
                'order' => [[2, 'desc']],
            ])
            ->addColumn(['data' => 'DT_RowIndex', 'name' => 'DT_RowIndex', 'title' => 'No', 'orderable' => false, 'searchable' => false, 'width' => 30])
            ->addColumn(['data' => 'trx_number', 'name' => 'trx_number', 'title' => 'Nomor Transaksi'])
            ->addColumn(['data' => 'created_at', 'name' => 'created_at', 'title' => 'Tanggal'])
            ->addColumn(['data' => 'customer.name', 'name' => 'customer.name', 'title' => 'Customer'])
            ->addColumn(['data' => 'status', 'status' => 'status', 'title' => 'Status'])
            ->addColumn(['data' => 'action', 'name' => 'action', 'title' => 'Aksi', 'orderable' => false, 'searchable' => false, 'width' => 100]);
        return view('transaction.index', compact('dataTable'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $items = Item::where('status', Item::STATUS_ACTIVE)->select('id', 'name')->get();
        return view('transaction.create', compact('items'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */ 
    public function store(Request $request)
    {
        $request->validate([
            'customer_id' => ['required'],
            'trx_number' => ['required'],
            // 'grand_total' => ['required'],
        ]);
        $model = new Transaction($request->all());
        // $model->user_id = Auth::user()->id;
        $model->save();
        foreach ($request->item as $key => $item) {
            $modelDetail = new TransactionDetail();
            $modelDetail->transaction_id = $model->id;
            $modelDetail->item_id = $item;
            $modelDetail->qty = $request->qty[$key];
            // $modelDetail->price = $request->price[$key];
            // $modelDetail->total_price = $request->total_price[$key];
            $modelDetail->save();

            $stocks = ItemStock::where('item_id', $modelDetail->item_id)->where('stock', '>', 0)->get();
            $diffStock = $modelDetail->qty;
            foreach($stocks as $stock) {
                $tempStock = $stock->stock;
                if ($diffStock <= 0) continue;
                if ($stock->stock >= $diffStock) {
                    $tempStock = (int)$stock->stock - (int)$diffStock;
                    $diffStock = 0;
                } else {
                    $diffStock = (int)$diffStock - (int)$tempStock;
                    $tempStock = 0;
                }
                $stock->stock = (int)$tempStock;
                $stock->save();
            }
        }
        return redirect()->route('transaction.index')->with('success', 'Sukses!');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $model = Transaction::find($id);
        return view('transaction.show', compact('model'));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function print($id)
    {
        $model = Transaction::find($id);
        return view('transaction.print', compact('model'));
    }

    public function ajaxGetItem($id) {
        $model = Item::find($id);
        if (!$model) {
            return response()->json(['success' => false, data => null]);
        }
        $stock = ItemStock::where('item_id', $id)->groupBy('item_id')->sum('stock');
        $model = $model->toArray();
        $model['stock'] = $stock;
        return response()->json(['success' => true, 'data' => $model]);
    }

    public function destroy($id)
    {
        $models = Transaction::find($id); 

        $data = DB::table('transactions')
            ->leftJoin('transaction_details', 'transaction_id', '=','transaction_details.transaction_id')
            ->where('transaction_id', $id);
            DB::table('transaction_details')->where('transaction_id', $id)->delete();
            $data->delete();
            $models->delete();
        
        return redirect()->route('transaction.index')->with('success', 'Sukses dihapus!');
    }
}
