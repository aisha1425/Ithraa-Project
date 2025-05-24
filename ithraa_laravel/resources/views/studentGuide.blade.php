@extends('layout.app')

@section('title', 'Student Guide')

@section('content')

<div class="d-flex flex-column">


    <div class="accom-card">
        <div class="d-flex gap-2 align-items-center px-2">
            <div style="background-color: purple; border-radius: 100%; padding: 10px 16px;">
                <i class="bi bi-shield-exclamation" width="100px" height="100px" style="border-radius: 10px; color: white;"></i>
            </div>
            <div class="d-flex flex-column">
                <h5>University Policy</h5>
                <p>Manage the important rules and policies of the university</p>
            </div>
        </div>
        <div class="d-flex gap-2 px-2">
            <a class="btn btn-primary " style="background-color: purple; border: none;" href="/policy">
                <i class="bi bi-caret-right-fill" style="color: white;"></i>
            </a>
           
        </div>
    </div>

    <div class="accom-card">
        <div class="d-flex gap-2 align-items-center px-2">
            <div style="background-color: purple; border-radius: 100%; padding: 10px 16px;">
                <i class="bi bi-person-lines-fill" width="100px" height="100px" style="border-radius: 10px; color: white;"></i>
            </div>
            <div class="d-flex flex-column">
                <h5>Important Contacts</h5>
                <p>Manage University key important contacts</p>
            </div>
        </div>
        <div class="d-flex gap-2 px-2">
            <a class="btn btn-primary" style="background-color: purple; border: none;" href="/contacts">
                <i class="bi bi-caret-right-fill" style="color: white;"></i>
            </a>
           
        </div>
    </div>


    

</div>


@endsection