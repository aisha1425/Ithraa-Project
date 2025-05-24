@extends('layout.default')

@section('content')
<div class="card-div flex-col-center">
    <h3>Admin Login</h3>
    <form class="flex-col-center w-100" method="post" action="/login">
        @csrf

        <input name="email" class="form-control" type="username" placeholder="User Name" />
        <input name="password" class="form-control" type="password" placeholder="Password" />
        <button class="btn btn-light w-100 text-primary fw-bold">Login</button>
    </form>
</div>
@endsection