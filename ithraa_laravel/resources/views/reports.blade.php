@extends('layout.app')

@section('title', 'Reports')

@section('content')
<div class="p-3 w-100">

    <select onchange="changeType()" id="selectType" class="form-control my-3">
        <option value="users">Users</option>
        <option value="Accomindations">Accomindations</option>
        <option value="Jobs">Jobs</option>
        <option value="Offers">Offers</option>
        <option value="Transports">Transports</option>
    </select>


</div>
<div class="chart-container" style="height: 500px; width: 100%;">
<canvas id="myChart"></canvas>
</div>
<script>
    let type = 'Users';
    let data = <?= json_encode($usersCounts) ?>;
    let labels = <?= json_encode($usersDays) ?>;
    let myChart;

    function changeType() {
        type = document.getElementById("selectType").value;

        if (type == "Users") {
            data = <?= json_encode($usersCounts) ?>;
            labels = <?= json_encode($usersDays) ?>;
        }
        if (type == "Accomindations") {
            data = <?= json_encode($accomindationsCounts) ?>;
            labels = <?= json_encode($accomindationsDays) ?>;
        }
        if (type == "Jobs") {
            data = <?= json_encode($jobsCounts) ?>;
            labels = <?= json_encode($jobsDays) ?>;
        }
        if (type == "Offers") {
            data = <?= json_encode($offerCounts) ?>;
            labels = <?= json_encode($offerDays) ?>;
        }
        if (type == "Transports") {
            data = <?= json_encode($transportsCounts) ?>;
            labels = <?= json_encode($transportsDays) ?>;
        }

        if (myChart) {
            myChart.destroy();
        }
        createChart();
    }

    function createChart() {
        const ctx = document.getElementById('myChart');
        myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Number of ' + type,
                    data: data,
                    borderWidth: 1,
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    borderColor: 'rgba(54, 162, 235, 1)'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    }

    document.addEventListener('DOMContentLoaded', createChart);
</script>

@endsection