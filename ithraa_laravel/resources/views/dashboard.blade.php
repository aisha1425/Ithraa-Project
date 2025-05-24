@extends('layout.app')

@section('title', 'Dashboard')

@section('content')




<div class="dashboard-home">
    <h3>Wellcome Admin</h3>
    <div class="d-flex flex-wrap gap-2">
        <a href="/users" class="flex-basis">
            <div class="d-flex  flex-column justify-content-between dashboard-card" style="height: 250px; padding: 16px;">
                <div class="d-flex flex-column">

                    <div class="rounded-circle card-icon" style="background-color: #CDF1FFFF;">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="fw-bold">Total Users</div>
                    <div class="fw-bold " style="color: blue;">{{$allUsers }}</div>
                </div>
                <div class="d-flex flex-column">

                    <div class="fw-bold">Student: {{ $users[0] }}</div>
                    <div class="fw-bold">Local Busniess: {{ $business }}</div>


                </div>

            </div>
        </a>


        <a href="/business" class="flex-basis">
            <div class="d-flex flex-column justify-content-between dashboard-card" style="height: 250px; padding: 16px;">
                <div class="d-flex flex-column">

                    <div class="rounded-circle card-icon" style="background-color: #A2E2DFFF;">
                        <i style="color: seagreen;" class="bi bi-check-lg"></i>
                    </div>
                    <div class="fw-bold">Approved Business</div>
                    <div class="fw-bold " style="color: seagreen;">{{ $acceptedBusiness[0] }}</div>
                </div>
                <div class="d-flex flex-column">


                    <div class="fw-bold">Business Approved successfuly</div>


                </div>

            </div>
        </a>

        <a href="/business" class="flex-basis">
            <div class="d-flex  flex-column justify-content-between dashboard-card" style="height: 250px; padding: 16px;">
                <div class="d-flex flex-column">

                    <div class="rounded-circle card-icon" style="background-color: #FAD2C7FF;">
                        <i class="bi bi-x-lg" style="color: red; font-size: 18px;"></i>
                    </div>
                    <div class="fw-bold">Rejected Businesses</div>
                    <div class="fw-bold " style="color: red;"> {{ $rejectedBusiness[0] }} </div>
                </div>
                <div class="d-flex flex-column">

                    <div class="fw-bold">Business rejected by admin</div>



                </div>

            </div>
        </a>


        <a href="/business" class="flex-basis">
            <div class="d-flex flex-column justify-content-between dashboard-card" style="height: 250px; padding: 16px;">
                <div class="d-flex flex-column">

                    <div class="rounded-circle card-icon" style="background-color: #FDDBABFF;">
                        <i style="color: orangered;" class="bi bi-three-dots fs-4"></i>
                    </div>
                    <div class="fw-bold">Pending Business</div>
                    <div class="fw-bold " style="color: orangered;"> {{ $pendingBusiness[0] }} </div>
                </div>
                <div class="d-flex flex-column">


                    <div class="fw-bold">Business waiting for aproval</div>


                </div>

            </div>
        </a>



        <a href="/accomindation" class="flex-basis">
            <div class="d-flex flex-column justify-content-between dashboard-card" style="height: 250px; padding: 16px;">
                <div class="d-flex flex-column">

                    <div class="rounded-circle card-icon" style="background-color: #E6CDDFFF;">
                        <i style="color: #AC00ACFF;" class="bi bi-house-fill"></i>
                    </div>
                    <div class="fw-bold">Total Accomindation</div>
                    <div class="fw-bold " style="color: purple;"> {{ $accomindation[0] }} </div>
                </div>
                <div class="d-flex flex-column">


                    <div class="fw-bold">Total Accomindation managed by platform</div>


                </div>

            </div>
        </a>

        <a href="/transport" class="flex-basis">
            <div class="d-flex flex-column justify-content-between dashboard-card" style="height: 250px; padding: 16px;">
                <div class="d-flex flex-column">

                    <div class="rounded-circle card-icon" style="background-color: #ECFFD6FF;">
                        <i style="color: #356400FF;" class="bi bi-taxi-front-fill"></i>
                    </div>
                    <div class="fw-bold">Transportaion</div>
                    <div class="fw-bold " style="color: #356400FF;"> {{ $transport[0] }} </div>
                </div>
                <div class="d-flex flex-column">


                    <div class="fw-bold">Available Transportation options</div>


                </div>

            </div>
        </a>
    </div>


</div>

@endsection