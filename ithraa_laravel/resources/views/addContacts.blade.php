@extends('layout.app')

@section('title', 'Contacts')

@section('content')

<div class="d-flex flex-column">

    <div class="d-flex flex-column px-5 py-2 gap-2 align-items-center justify-content-center">

        <form class="d-flex flex-column w-50 gap-2" method="post" action="{!! !empty($contact) ? '/editcontacts' : '/addcontacts' !!}">
            @csrf
            @if(!empty($contact))
            <input type="hidden" name="id" value="{{ $contact->id }}" />
            @endif
            <input name="name" value="{{ $contact->name ?? '' }}" class="form-control" type="text" placeholder="Add Contact Name" />

            <input name="phone" value="{{ $contact->phone ?? '' }}" class="form-control" type="text" placeholder="Add Phone Number" />
            <input name="email" value="{{ $contact->email ?? '' }}" class="form-control" type="email" placeholder="Add Email Address" />
            <button type="submit" class="btn btn-success ">Save</button>
        </form>
    </div>


</div>



@endsection