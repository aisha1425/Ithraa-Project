@extends('layout.app')

@section('title', 'Accomindation')

@section('content')

<div class="d-flex flex-column">

    @foreach($accomindations as $accomindation)
    <div class="accom-card">
        <div class="d-flex gap-2 align-items-center">
            <img src="{{ asset('images/'.$accomindation->image) }}" alt="" width="80px" height="80px" style="border-radius: 10px;" />
            <div class="d-flex flex-column">
                <h5>{{ $accomindation->name }}</h5>
                <p>{{ $accomindation->description }}</p>
            </div>
        </div>
        <div class="d-flex gap-2 px-2">
            <a class="btn btn-success" href="/editaccomindation/{{$accomindation->id }}">
                <i class="bi bi-pencil-fill" style="color: white;"></i>
            </a>
            <a class="btn btn-danger" href="/deleteaccomindation/{{ $accomindation->id }}">
                <i class="bi bi-trash-fill" style="color: white;"></i>

            </a>
        </div>
    </div>
    @endforeach


    <a href="/addaccomindation" class="btn-add">
        +
    </a>

</div>




@endsection