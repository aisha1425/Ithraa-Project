@extends('layout.app')

@section('title', 'Add Transportation')

@section('content')

<div class="w-100">
    <form action="{!! !empty($transport) ? '/edittransport' : '/addtransport' !!}" enctype="multipart/form-data" method="post" class="w-100 p-4 d-flex align-items-center justify-content-center flex-column gap-2">
        @csrf
        @if(!empty($transport))
        <input type="hidden" name="id" value="{{ $transport->id }}" />
        @endif
        <div class="form-group w-100">
            <label>Name</label>
            <input value="{{ $transport->name ?? '' }}" type="text" required class="form-control" name="name" placeholder="Name" />

        </div>


            <div class="form-group w-100">
                <label>Description</label>
                <input value="{{ $transport->description ?? '' }}" required type="text" class="form-control" name="description" placeholder="Description" />
            </div>





            <div class="form-group w-100">
                <label>Cost</label>
                <input value="{{ $transport->cost ?? '' }}" required type="number" class="form-control" name="cost" placeholder="Cost" />
            </div>
            <div class="form-group w-100">
                <label>Distance</label>
                <input value="{{ $transport->distance ?? '' }}" required type="number" class="form-control" name="distance" placeholder="Distance" />
            </div>



            <div class="form-group w-100">
                <label>Availability</label>
                <input value="{{ $transport->availability ?? '' }}" required type="text" class="form-control" name="availability" placeholder="Availability" />
            </div>
          



            <div class="form-group w-100">
                <label>Vechile Type</label>
                <select required name="type">
                    @if(empty($transport))
                    <option value="Microbus">Microbus</option>
                    <option value="Bus">Bus</option>
                    <option value="Taxi">Taxi</option>
                    <option value="Private Car">Private Car</option>
                    @else
                    @if($transport->type == "Microbus")
                    <option selected value="Microbus">Microbus</option>
                    @else
                    <option value="Microbus">Microbus</option>
                    @endif


                    @if($transport->type == "Bus")
                    <option selected value="Bus">Bus</option>
                    @else
                    <option value="Bus">Bus</option>
                    @endif

                    @if($transport->type == "Taxi")
                    <option selected value="Taxi">Taxi</option>
                    @else
                    <option value="Taxi">Taxi</option>
                    @endif

                    @if($transport->type == "Taxi")
                    <option selected value="Private Car">Private Car</option>
                    @else
                    <option value="Private Car">Private Car</option>
                    @endif
                    @endisset

                </select>
            </div>


        <button class="btn btn-success">Save</button>
    </form>
</div>


@endsection