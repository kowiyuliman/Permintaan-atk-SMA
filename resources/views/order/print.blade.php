<style>
    table th {
        text-align: left;
    }
</style>
<h3>Cetak ATK Masuk</h3>
<table>
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
        <th>Created At</th>
        <td>{!! $model->created_at !!}</td>
    </tr>
</table>
<table width="100%" border="1">
    <tr>
        <th>No</th>
        <th>Nama Barang</th>
        <th>Satuan</th>
        <th>Jumlah</th>
    </tr>
    @foreach ($model->orderDetails as $key => $orderDetail)
        <tr>
            <td>{{ $key + 1 }}</td>
            <td>{!! $orderDetail->item->name !!}</td>
            <td>{!! $orderDetail->item->satuan !!}</td>
            <td>{!! $orderDetail->qty !!}</td>
        </tr>
    @endforeach
</table>
