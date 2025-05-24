@extends('layout.app')

@section('title', 'Contacts')

@section('content')

<div class="d-flex flex-column  ">

    @foreach($contacts as $contact)
    <div class="policy p-2 mx-5">

        <div class="policy-card py-2">
            <div class="d-flex gap-2 w-100 align-items-center mx-2 justify-content-between">

                <div class="d-flex flex-column">
                    <h5>{{$contact->name}}</h5>
                    <h6>{{$contact->phone}}</h6>
                    <h6>{{$contact->email}}</h6>

                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-success" href="/editcontacts/{{$contact->id}}">
                        <i class="bi bi-pencil-fill" style="color: white;"></i>
                    </a>
                    <a class="btn btn-danger" href="/deletecontacts/{{$contact->id}}">
                        <i class="bi bi-trash-fill" style="color: white;"></i>

                    </a>
                </div>
            </div>

        </div>

    </div>

    @endforeach


    <a href="/addcontacts" class="btn-add">
        +
    </a>



</div>



@endsection