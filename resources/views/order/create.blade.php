@extends('adminlte::page')

@section('content')
    <div class="container" id="OrderForm">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">{{ __('Tambah ATK In') }}</div>

                    <div class="card-body">
                        {!! Form::open(['route' => ['order.store'], 'method' => 'post']) !!}
                        @if ($errors->any())
                            <div class="alert alert-danger">
                                <ul>
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div><br>
                        @endif
                        @csrf
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    {!! Form::label('order_number', 'Nomor Pembelian') !!}
                                    {!! Form::text('order_number', \App\Models\Order::generateOrderNumber(), ['class' => $errors->has('order_number') ? 'form-control is-invalid' : 'form-control', 'readonly' => true, 'required'=>true]) !!}
                                    @if($errors->has('order_number'))
                                        <div class="invalid-feedback">
                                            <strong>{{ $errors->first('order_number') }}</strong>
                                        </div>
                                    @endif
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    {!! Form::label('order_date', 'Tanggal Pembelian') !!}
                                    {!! Form::date('order_date', null, ['class' => $errors->has('order_number') ? 'form-control is-invalid' : 'form-control', 'required'=>true]) !!}
                                    @if($errors->has('order_date'))
                                        <div class="invalid-feedback">
                                            <strong>{{ $errors->first('order_date') }}</strong>
                                        </div>
                                    @endif
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    {!! Form::label('supplier_id', 'Supplier') !!}
                                    {!! Form::select('supplier_id',  [null => 'Pilih Supplier'] + \App\Models\Supplier::pluck('name', 'id')->toArray(), null, ['class' => $errors->has('phone') ? 'form-control is-invalid' : 'form-control', 'required'=>true]) !!}
                                    @if($errors->has('supplier_id'))
                                        <div class="invalid-feedback">
                                            <strong>{{ $errors->first('supplier_id') }}</strong>
                                        </div>
                                    @endif
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                        {!! Form::label('image', 'Unggah Surat Jalan') !!}
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="exampleInputFile">
                                        <label class="custom-file-label" for="exampleInputFile">
                                            Choose File
                                           
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    {!! Form::label('note', 'Catatan') !!}
                                    {!! Form::text('note', null, ['class' => $errors->has('note') ? 'form-control is-invalid' : 'form-control']) !!}
                                    @if($errors->has('note'))
                                        <div class="invalid-feedback">
                                            <strong>{{ $errors->first('note') }}</strong>
                                        </div>
                                    @endif
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                Pilih Barang
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th width="10">No</th>
                                        <th>Nama ATK</th>
                                        <th>Satuan</th>
                                        <th>Jumlah</th>
                                    </tr>
                                    </thead>
                                    <tbody id="items">
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td colspan="4"><a href="javascript:;;" id="add-item" class="btn btn-success">
                                            <i class="fa fa-plus"></i>&nbsp; Tambah Barang</a>
                                        </td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i>&nbsp;&nbsp;{{ 'Simpan' }}</button>
                        {!! Form::close() !!}
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('js')
    <script type="text/javascript">
        let number = 0
        let totalArray = []
        $('#add-item').click(function() {
            const itemsJson = @json($items);
            let itemSelect = '';
            if (itemsJson.length > 0) {
                itemSelect += "<option value=''>Pilih</option>"
                itemsJson.map(result => {
                    itemSelect += "<option value='"+result.id+"'>"+result.name+"</option>"
                })
            }
            let itemsHtml = "<tr>\n" +
                "<th>"+ (number + 1) +"</th>\n" +
                "<th><select name='item["+number+"]' class='form-control' required onchange='onChangeItem("+number+", this)'>"+itemSelect+"</select></th>\n" +
                "<th><div id='satuan_"+number+"'></div></th>\n" +
                "<th><input name='qty["+number+"]' type='number' class='form-control' onkeyup='onChangeQty("+number+")' required></th>\n" +
                "<th><button class='btn btn-danger remove-table-row' </button>delete</th>\n" +
                "</tr>"
                
            $('#items').append(itemsHtml)
            number++
        })
        function onChangeQty(number) {
            let satuan = $('#satuan_' + number).html()
           
        }
        function onChangeItem(number, itemId) {
            console.log(number)
            if (itemId.value === '') {
                alert('Pilih Barang')
                return
            }
            $.ajax({
                url: '/transaction/ajax-get-item/' + itemId.value,
                success: function(result) {
                    console.log(result)
                    $('#satuan_' + number).html(result.data.satuan)
                }
            })  
        }
        
        //delete
        $(document).on('click','.remove-table-row',function(){
            $(this).parents('tr').remove();
        });
    </script>
@endpush
