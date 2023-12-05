<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Yajra\Datatables\Datatables;
use Yajra\DataTables\Html\Builder;

class CustomerController extends Controller
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
            $data = Customer::select(['*']);
            $datatables = DataTables::of($data)
                ->addIndexColumn()
                ->addColumn('action', function($row){
                    $editRoute = route('customer.edit', ['customer' => $row->id ]);
                    $deleteRoute = route('customer.destroy', ['customer' => $row->id ]);
                    $csrf = csrf_field(); $method = method_field('DELETE');
                    $btn = "<div class='d-flex'>
                                <a href='{$editRoute}' class='btn btn-sm btn-primary'>
                                    <i class='far fa-edit icon-nm'></i>
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
            ])
            ->addColumn(['data' => 'DT_RowIndex', 'name' => 'DT_RowIndex', 'title' => 'No', 'orderable' => false, 'searchable' => false, 'width' => 30])
            ->addColumn(['data' => 'name', 'name' => 'name', 'title' => 'Nama'])
            ->addColumn(['data' => 'phone', 'name' => 'phone', 'title' => 'Telp'])
            ->addColumn(['data' => 'departemen', 'name' => 'departemen', 'title' => 'Departemen'])
            // ->addColumn(['data' => 'created_at', 'name' => 'created_at', 'title' => 'Created At'])
            // ->addColumn(['data' => 'updated_at', 'name' => 'updated_at', 'title' => 'Updated At'])
            ->addColumn(['data' => 'action', 'name' => 'action', 'title' => 'Aksi', 'orderable' => false, 'searchable' => false, 'width' => 100]);
        return view('customer.index', compact('dataTable'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('customer.create');
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
            'name' => ['required'],
            'phone' => ['required', 'numeric'],
            'departemen' => ['required'],
        ]);
        $models = new Customer($request->all());
        $models->save();
        return redirect()->route('customer.index')->with('success', 'Sukses!');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $model = Customer::find($id);
        return view('customer.edit', compact('model'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => ['required'],
            'phone' => ['required', 'numeric'],
            'departemen' => ['required'],
        ]);
        $model = Customer::find($id);
        $model->fill($request->all());
        $model->save();
        return redirect()->route('customer.index')->with('success', 'Sukses!');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $models = Customer::find($id);
        $models->delete();

        return redirect()->route('customer.index')->with('success', 'Sukses dihapus!');
    }
}
