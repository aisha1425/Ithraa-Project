@extends('layout.app')

@section('title', 'Users Accounts')

@section('content')

<div class="d-flex flex-column">

    <div id="pendingSection">
        @foreach($users as $user)
        <div class="accom-card p-3">
            <div class="d-flex">
                <div class="d-flex flex-column">
                    <h5>{{ $user->username }}</h5>
                    <div>Email : {{ $user->email }}</div>
                    <div>Phone : {{ $user->phone }}</div>

                </div>
            </div>
            <div class="d-flex flex-column gap-2 px-2">


                <a class="btn btn-danger d-flex justify-content-center align-items-center gap-1" href="/deleteStudent/{{ $user->id }}" style="color: white !important;">
                    <i class="bi bi-trash-fill" style="color: white;"></i> Delete
                </a>
            </div>
        </div>
        @endforeach
    </div>



    @endsection