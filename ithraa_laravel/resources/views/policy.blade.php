@extends('layout.app')

@section('title', 'University Policy')

@section('content')

<div class="d-flex flex-column  ">

    <div class="d-flex flex-column px-5 py-2 gap-2 align-items-center">

        <form class="d-flex flex-column w-50 gap-2" method="post" action="/addpolicy">
            @csrf
            <input name="policy" class="form-control" type="text" placeholder="Add policy" />
            <button type="submit" class="btn btn-success ">Add</button>
        </form>
    </div>

    @php($i = 0)
    @foreach($policies as $policy)
    <div class="policy p-3">

        <div class="policy-card py-2">
            <div class="d-flex gap-2 align-items-center px-2">

                <div class="d-flex flex-column">
                    <h5>{{$policy->name}}</h5>

                </div>
            </div>
            <div class="d-flex gap-2 px-2" onclick="openwrap('{{$i}}')">
                <div class="arrow-toggle">
                    <i class="bi bi-caret-right-fill"></i>
                </div>

            </div>
        </div>
        <div id="wrap{{$i}}" class="wrap hidden-wrap px-3">


            @if($policy->details != "")
                Policy Link : 
            <a class="py-3 link-primary link-offset-2 link-underline-primary link-underline-opacity-100-hover" href="/images/{{$policy->details}}">
                {{$policy->details}} 
            </a>
            @endif

            <form class="d-flex gap-2 pt-3" action="/addpolicyitem" method="post" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="id" value="{{$policy->id}}" />
                <input name="item" class="form-control" type="file" placeholder="Add item" />
                <button type="submit" class="btn btn-success ">Add</button>
            </form>
        </div>
    </div>
    @php($i = $i+1)
    @endforeach






</div>



@endsection