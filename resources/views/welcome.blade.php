@extends('adminlte::auth.auth-page')

@section('auth_body')
    Selamat Datang di Aplikasi SMA-is<br/><br/>
    <a href="{{ route('login') }}" class="btn btn-primary">Login</a>
@endsection
