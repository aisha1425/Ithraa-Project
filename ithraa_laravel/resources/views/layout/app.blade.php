<!DOCTYPE html>
<html lang="en">

<head>

    @include('includes.header')


</head>

<body>
    <div class="dashboard" style="background-color: #FDF4FFFF;">

        <div class="left-part">
            <a href="{{url('/')}}">

                <div class="left-item {{ Request::is('/') ? 'active' : '' }}">
                    <i class="bi bi-speedometer"></i>
                    <p>Dashboard</p>
                </div>
            </a>


            <a href="{{url('/accomindation')}}">

                <div class="left-item {{ Request::is('accomindation') ? 'active' : '' }}">
                    <i class="bi bi-house-door-fill"></i>
                    <p>Accomindation</p>
                </div>
            </a>

            <a href="{{url('/transport')}}">

                <div class="left-item {{ Request::is('transport') ? 'active' : '' }}">
                    <i class="bi bi-bus-front"></i>
                    <p>Transporation</p>
                </div>
            </a>
            <a href="{{url('/guide')}}">
                <div class="left-item {{ Request::is('guide') ? 'active' : '' }}">
                    <i class="bi bi-book-half"></i>
                    <p>Student Guide</p>
                </div>
            </a>
            <a href="{{url('/forum')}}">

                <div class="left-item {{ Request::is('forum') ? 'active' : '' }}">
                    <i class="bi bi-chat-left-text"></i>
                    <p>Student Forum</p>
                </div>
            </a>
            <a href="{{url('/business')}}">

                <div class="left-item {{ Request::is('business') ? 'active' : '' }}">
                    <i class="bi bi-buildings"></i>
                    <p>Local Bussiness</p>
                </div>
            </a>
            <a href="{{url('/users')}}">
                <div class="left-item {{ Request::is('users') ? 'active' : '' }}">
                    <i class="bi bi-people"></i>
                    <p>User Accounts</p>
                </div>
            </a>
            <a href="{{url('/reports')}}">
                <div class="left-item {{ Request::is('reports') ? 'active' : '' }}">
                    <i class="bi bi-bar-chart"></i>
                    <p>Reports</p>
                </div>
            </a>

        </div>

        <div class="right-part">

            <div class="top-bar">
                <p></p>
                <h3>@yield('title')</h3>
                <a style="text-decoration: none;">
                    <div class="rounded-circle top-bar-icon">AA</div>
                </a>
            </div>


            @yield('content')
        </div>

    </div>
    @include('includes.footer')
</body>

</html>