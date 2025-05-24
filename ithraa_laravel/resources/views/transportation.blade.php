@extends('layout.app')

@section('title', 'Transportation')

@section('content')

<div class="d-flex flex-column">

    @foreach($transports as $transport)
    <div class="accom-card">
        <div class="d-flex gap-2 align-items-center px-2">
            <div style="background-color: purple; border-radius: 100%; padding: 10px 16px;">

                @if($transport->type == "Taxi")
                <i class="bi bi-taxi-front-fill" width="80px" height="80px" style="border-radius: 10px; color: white;"></i>
                @endif
                @if($transport->type == "Private Car")
                <i class="bi bi-car-front-fill" width="80px" height="80px" style="border-radius: 10px; color: white;"></i>
                @endif
                @if($transport->type == "Bus" || $transport->type == "Microbus")
                <i class="bi bi-bus-front-fill" width="80px" height="80px" style="border-radius: 10px; color: white;"></i>
                @endif
            </div>
            <div class="d-flex flex-column">
                <h5>{{ $transport->name }}</h5>
                <p>{{ $transport->description }}</p>
            </div>
        </div>
        <div class="d-flex gap-2 px-2">
            <a class="btn btn-success" href="/edittransport/{{$transport->id }}">
                <i class="bi bi-pencil-fill" style="color: white;"></i>
            </a>
            <a class="btn btn-danger" href="/deletetransport/{{ $transport->id }}">
                <i class="bi bi-trash-fill" style="color: white;"></i>

            </a>
        </div>
    </div>
    @endforeach


    <a href="/addtransport" class="btn-add">
        +
    </a>

</div>


@endsection