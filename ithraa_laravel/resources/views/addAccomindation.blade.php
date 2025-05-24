@extends('layout.app')

@section('title', 'Add Accomindation')

@section('content')

<div class="w-100">
    <form action="{!! !empty($accomindation) ? '/editaccomindation' : '/addaccomindation' !!}" enctype="multipart/form-data" method="post" class="w-100 p-4 d-flex align-items-center justify-content-center flex-column gap-2">
        @csrf
        <label for="image">
            @if(!empty($accomindation))
            <input type="hidden" name="id" value="{{ $accomindation->id }}" />
            <img src="{{ asset('images/'). '/'. $accomindation->image }}" height="160px" id="output" />
            @else
            <img src="{{ asset('images/dorms.jpeg') }}" height="160px" id="output" />
            @endif
        </label>
        <input type="file" name="image" class="invisible" id="image" accept="image/*" onchange="document.getElementById('output').src = window.URL.createObjectURL(this.files[0])" />

        <div class="form-group w-100">
            <label>Name</label>
            <input required value="{{ $accomindation->name ?? '' }}" type="text" class="form-control" name="name" placeholder="Name" />

        </div>

        <div class="d-flex w-100 gap-2">
            <div class="form-group w-100">
                <label>Description</label>
                <input required value="{{ $accomindation->description ?? '' }}" type="text" class="form-control" name="description" placeholder="Description" />
            </div>
            <div class="form-group w-100">
                <label>Location</label>
                <input value="{{ $accomindation->location ?? '' }}" type="text" class="form-control" name="location" placeholder="Location" />
            </div>
        </div>

        <div class="d-flex w-100 gap-2">
            <div class="form-group w-100">
                <label>Price</label>
                <input required value="{{ $accomindation->price ?? '' }}" type="number" class="form-control" name="price" placeholder="Price" />
            </div>
            <div class="form-group w-100">
                <label>Distance</label>
                <select required class="form-control" name="distance">
                    @if(empty($accomindation))
                        <option selected value="العقيق">العقيق</option>
                        <option value="بهر">بهر</option>
                        <option value="شهبه">شهبه</option>
                    @else
                        @if($accomindation->distance == 'العقيق')
                            <option selected value="العقيق">العقيق</option>
                            <option value="بهر">بهر</option>
                            <option value="شهبه">شهبه</option>
                        @elseif($accomindation->distance == 'بهر')
                            <option value="العقيق">العقيق</option>
                            <option selected value="بهر">بهر</option>
                            <option value="شهبه">شهبه</option>
                        @else
                            <option value="العقيق">العقيق</option>
                            <option value="بهر">بهر</option>
                            <option selected value="شهبه">شهبه</option>
                        @endif
                    @endif
                </select>
               
            </div>
        </div>

        <div class="d-flex align-items-center w-100 gap-2">
            <div class="form-group w-100">
                <label>Bedrooms</label>
                <input required value="{{ $accomindation->bedrooms ?? '' }}" type="number" class="form-control" name="bedrooms" placeholder="Bed Rooms" />
            </div>
            <div class="form-group w-100">
                <label>Bath Rooms</label>
                <input required value="{{ $accomindation->bathrooms ?? '' }}" type="number" class="form-control" name="bathrooms" placeholder="Bath Rooms" />
            </div>
        </div>

        <div class="d-flex gap-2 w-100 align-items-center">
            <div class="form-group w-100">
                <label>Type</label>
                <select required name="type">
                     <option selected value="Off-Campus">Off-Campus</option>
                </select>
            </div>

            <div class="form-group w-100">
                <label>Phone Number</label>
                <input required value="{{ $accomindation->call ?? '' }}" type="number" class="form-control" name="call" placeholder="Phone Number" />
            </div>
        </div>

        <div class="d-flex gap-2 justify-content-between w-100">
            <div class="d-flex form-group w-100 gap-2">
                <label>Kitchen</label>
                <input required value="{{ $accomindation->kitchen ?? '' }}" type="checkbox" name="kitchen" />
            </div>
            <div class="d-flex form-group w-100 gap-2">
                <label>Laundary</label>
                <input required value="{{ $accomindation->laundary ?? '' }}" type="checkbox" name="laundary" />
            </div>
            <div class="d-flex form-group w-100 gap-2">
                <label>Parking Spot</label>
                @isset($accomindation)
                @if($accomindation->parking == "Available")
                <input checked type="checkbox" name="parking" />
                @else
                <input type="checkbox" name="parking" />
                @endif
                @endisset
            </div>
            <div class="d-flex form-group w-100 gap-2">
                <label>Internet</label>
                @isset($accomindation)
                @if($accomindation->parking == "Available")
                <input checked type="checkbox" name="internet" />
                @else
                <input type="checkbox" name="parking" />
                @endif
                @endisset
            </div>
        </div>




        <button class="btn btn-success">Save</button>
    </form>
</div>


@endsection