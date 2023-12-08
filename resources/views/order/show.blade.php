@extends('adminlte::page')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">{{ __('Detail Atk Masuk') }}   <a href="{{ route('order.index') }}" class="btn btn-sm btn-primary">Kembali</a></div>

                    <div class="card-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>Nomor Order</th>
                                <td>{!! $model->order_number !!}</td>
                            </tr>
                            <tr>
                                <th>Tanggal Order</th>
                                <td>{!! \Carbon\Carbon::parse($model->order_date)->toDateString() !!}</td>
                            </tr>
                            <tr>
                                <th>Supplier</th>
                                <td>{!! $model->supplier->name !!}</td>
                            </tr>
                            <tr>
                                <th>Catatan</th>
                                <td>{!! $model->note !!}</td>
                            </tr>
                            <tr>
                                <th>Image</th>
                                <td>{!! $model->image !!}</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">{{ __('Detail Barang') }}</div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>No</th>
                                <th>Nama Barang</th>
                                <th>Jumlah</th>
                                <th>Satuan</th>
                            </tr>
                            @foreach ($model->orderDetails as $key => $orderDetail)
                                <tr>
                                    <td>{{ $key + 1 }}</td>
                                    <td>{!! $orderDetail->item->name !!}</td>
                                    <td>{!! $orderDetail->qty !!}</td>
                                    <td>{!! $orderDetail->item->satuan !!}</td>
                                    {{-- <td>{!! \App\Helpers\FormatConverter::rupiahFormat($orderDetail->price) !!}</td> --}}
                                    {{-- <td>{!! \App\Helpers\FormatConverter::rupiahFormat($orderDetail->purchase_total) !!}</td> --}}
                                </tr>
                            @endforeach
                            {{-- <tr>
                                <th class="text-right" colspan="4">Total Keseluruhan</th>
                                <th>{!! \App\Helpers\FormatConverter::rupiahFormat($model->grand_total) !!}</th>
                            </tr> --}}
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
