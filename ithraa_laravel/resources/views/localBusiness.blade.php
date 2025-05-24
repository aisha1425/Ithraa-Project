@extends('layout.app')

@section('title', 'Local Business')

@section('content')

<div class="d-flex flex-column">
    <div class="d-flex justify-content-around pt-5">
        <div id="pendingTab" class="d-flex flex-column align-items-center fadedItem activeItem" onclick="showTab('pending')">
            <i class="bi bi-three-dots" style="font-size: 24px;"></i>
            <p>Pending</p>
        </div>

        <div id="acceptedTab" class="d-flex flex-column align-items-center fadedItem" onclick="showTab('accepted')">
            <i class="bi bi-check-circle-fill" style="font-size: 24px;"></i>
            <p>Accepted</p>
        </div>

        <div id="rejectedTab" class="d-flex flex-column align-items-center fadedItem" onclick="showTab('rejected')">
            <i class="bi bi-x-circle-fill" style="font-size: 24px;"></i>
            <p>Rejected</p>
        </div>
    </div>
    <hr />

    <!-- Pending Businesses -->
    <div id="pendingSection">
        @foreach($pendingUsers as $user)
        <div class="accom-card p-3">
            <div class="d-flex">
                <div class="d-flex flex-column">
                    <h5>{{ $user->username }}</h5>
                    <div>Email : {{ $user->email }}</div>
                    <div>Phone : {{ $user->phone }}</div>
                    <div>Rgister Number : {{ $user->regNumber }}</div>
                    <div>Location : {{ $user->location }}</div>
                    <div>Contact : {{ $user->contact }}</div>
                    <div>Website : {{ $user->website }}</div>
                    <div>Type : {{ $user->businessType }}</div>
                </div>
            </div>
            <div class="d-flex flex-column gap-2 px-2">
                @if($user->regFile != "")
                <a class="btn btn-warning" href="{{ asset('images/'.$user->regFile) }}" style="color: white !important;">
                    Check Registration File
                </a>
                @endif
                <a class="btn btn-success d-flex justify-content-center align-items-center gap-1" href="/acceptBusiness/{{$user->id }}" style="color: white !important;">
                    <i class="bi bi-check-lg" style="color: white; font-size: 16px;"></i>Accept
                </a>
                <a class="btn btn-danger d-flex justify-content-center align-items-center gap-1" href="/rejectBusiness/{{ $user->id }}" style="color: white !important;">
                    <i class="bi bi-trash-fill" style="color: white;"></i> Reject
                </a>
            </div>
        </div>
        @endforeach
    </div>

    <!-- Accepted Businesses -->
    <div id="acceptedSection" style="display: none;">
        @foreach($acceptedUsers as $user)
        <div class="accom-card p-3">
            <div class="d-flex">
                <div class="d-flex flex-column">
                    <h5>{{ $user->username }}</h5>
                    <div>Email : {{ $user->email }}</div>
                    <div>Phone : {{ $user->phone }}</div>
                    <div>Rgister Number : {{ $user->regNumber }}</div>
                    <div>Location : {{ $user->location }}</div>
                    <div>Contact : {{ $user->contact }}</div>
                    <div>Website : {{ $user->website }}</div>
                    <div>Type : {{ $user->businessType }}</div>
                </div>
            </div>
            <div class="d-flex flex-column gap-2 px-2">
                @if($user->regFile != "")
                <a class="btn btn-warning" href="{{ asset('images/'.$user->regFile) }}" style="color: white !important;">
                    Check Registration File
                </a>
                @endif
                <a class="btn btn-danger d-flex justify-content-center align-items-center gap-1" href="/rejectBusiness/{{ $user->id }}" style="color: white !important;">
                    <i class="bi bi-trash-fill" style="color: white;"></i> Reject
                </a>
            </div>
        </div>
        @endforeach
    </div>

    <!-- Rejected Businesses -->
    <div id="rejectedSection" style="display: none;">
        @foreach($rejectedUsers as $user)
        <div class="accom-card p-3">
            <div class="d-flex">
                <div class="d-flex flex-column">
                    <h5>{{ $user->username }}</h5>
                    <div>Email : {{ $user->email }}</div>
                    <div>Phone : {{ $user->phone }}</div>
                    <div>Rgister Number : {{ $user->regNumber }}</div>
                    <div>Location : {{ $user->location }}</div>
                    <div>Contact : {{ $user->contact }}</div>
                    <div>Website : {{ $user->website }}</div>
                    <div>Type : {{ $user->businessType }}</div>
                </div>
            </div>
            <div class="d-flex flex-column gap-2 px-2">
                @if($user->regFile != "")
                <a class="btn btn-warning" href="{{ asset('images/'.$user->regFile) }}" style="color: white !important;">
                    Check Registration File
                </a>
                @endif
                <a class="btn btn-success d-flex justify-content-center align-items-center gap-1" href="/acceptBusiness/{{$user->id }}" style="color: white !important;">
                    <i class="bi bi-check-lg" style="color: white; font-size: 16px;"></i>Accept
                </a>
            </div>
        </div>
        @endforeach
    </div>
</div>

<script>
    function showTab(tabName) {
        // Hide all sections
        document.getElementById('pendingSection').style.display = 'none';
        document.getElementById('acceptedSection').style.display = 'none';
        document.getElementById('rejectedSection').style.display = 'none';

        // Remove active class from all tabs
        document.getElementById('pendingTab').classList.remove('activeItem');
        document.getElementById('acceptedTab').classList.remove('activeItem');
        document.getElementById('rejectedTab').classList.remove('activeItem');

        // Show selected section and mark tab as active
        document.getElementById(tabName + 'Section').style.display = 'block';
        document.getElementById(tabName + 'Tab').classList.add('activeItem');
    }
</script>

@endsection