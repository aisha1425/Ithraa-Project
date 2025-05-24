<?php

namespace App\Http\Controllers;

use App\Models\Accomindation;
use App\Models\Job;
use App\Models\Offer;
use App\Models\Transport;
use App\Models\User;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;

use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        if (Session::get('email') != null) {
            $users = User::select(DB::raw("COUNT(*) as count"))
                ->where('type', '=', 'Student')
                ->pluck('count');

            $pendingBusiness = User::select(DB::raw("COUNT(*) as count"))
                ->where('type', '=', 'Local Business')
                ->where('status', '=', 0)
                ->pluck('count');

            $acceptedBusiness = User::select(DB::raw("COUNT(*) as count"))
                ->where('type', '=', 'Local Business')
                ->where('status', '=', 1)
                ->pluck('count');

            $rejectedBusiness = User::select(DB::raw("COUNT(*) as count"))
                ->where('type', '=', 'Local Business')
                ->where('status', '=', 2)
                ->pluck('count');

            $accomindation = Accomindation::select(DB::raw("COUNT(*) as count"))
                ->pluck('count');

            $transport = Transport::select(DB::raw("COUNT(*) as count"))
                ->pluck('count');
            // return $users[0];
            $business = $pendingBusiness[0] + $acceptedBusiness[0] + $rejectedBusiness[0];
            $allUsers = $users[0] + $business;
            return view('dashboard', compact('allUsers', 'users', 'business', 'pendingBusiness', 'acceptedBusiness', 'rejectedBusiness', 'accomindation', 'transport'));
        } else
            return redirect('/login');
    }

    public function login()
    {
        return view('login');
    }

    public function loginProcess(Request $request)
    {
        $email = $request->input("email");
        $password = $request->input("password");


        $user = User::where('email', '=', $email)->where('password', '=', $password)->first();

        if ($user) {
            Session::put('email', $email);

            // return Session::get('email');
            return redirect('/');
        } else {
            $error = 'Invalid Credentials';
            return view('login')->with("error", ['Invalid Credentials']);
        }
    }






    public function accomindation()
    {
        if (Session::get('email') != null) {

            $accomindations = Accomindation::all();

            return view('accomindation')->with('accomindations', $accomindations);
        } else
            return redirect('/login');
    }
    public function addAccomindation()
    {
        if (Session::get('email') != null)
            return view('addAccomindation');
        else
            return redirect('/login');
    }



    public function editAccomindation($id)
    {
        if (Session::get('email') != null) {
            $accomindation = Accomindation::where('id', '=', $id)->first();

            return view('addAccomindation')->with('accomindation', $accomindation);
        } else
            return redirect('/login');
    }

    public function editAccomindationProcess(Request $request)
    {
        $data = Accomindation::where('id', '=', $request->input('id'))->first();
        $data->name = $request->input('name');
        $data->description = $request->input('description');
        $data->location = $request->input('location');
        $data->price = $request->input('price');
        $data->distance = $request->input('distance');
        $data->type = $request->input('type');
        $data->kitchen = ($request->input('kitchen') == 'on') ? "Available" : "Not Available";

        $data->laundary = ($request->input('laundary') == 'on') ? "Available" : "Not Available";
        $data->parking = ($request->input('parking') == 'on') ? "Available" : "Not Available";
        $data->bedrooms = $request->input('bedrooms');
        $data->bathrooms = $request->input('bathrooms');

        $data->internet = ($request->input('internet') == 'on') ? "Available" : "Not Available";
        $data->call = $request->input('call');
        $data->userEmail = 'admin@admin.com';


        if ($request->file('image')) {
            $file = $request->file('image');
            $filename = date('YmdHi') . $file->getClientOriginalName();
             $manager = new ImageManager(new Driver());

            $image = $manager->read($file->getRealPath());

            // Resize width to max 1200px (you can change this), maintain aspect ratio
    $image->resize(200, 200, function ($constraint) {
                $constraint->aspectRatio();
                $constraint->upsize(); // prevent upsizing smaller images
            });
            // Save the compressed image (quality from 0–100)
            $image->save($path, 70); // 70% quality to reduce size
            $data['image'] = $filename;
        }
        $data->update();
        return redirect('/accomindation');
    }

    public function addAccomindationProcess(Request $request)
    {
        $data = new Accomindation();
        $data->name = $request->input('name');
        $data->description = $request->input('description');
        $data->location = $request->input('location');
        $data->price = $request->input('price');
        $data->distance = $request->input('distance');
        $data->type = $request->input('type');
        $data->kitchen = ($request->input('kitchen') == 'on') ? "Available" : "Not Available";

        $data->laundary = ($request->input('laundary') == 'on') ? "Available" : "Not Available";
        $data->parking = ($request->input('parking') == 'on') ? "Available" : "Not Available";
        $data->bedrooms = $request->input('bedrooms');
        $data->bathrooms = $request->input('bathrooms');

        $data->internet = ($request->input('internet') == 'on') ? "Available" : "Not Available";
        $data->call = $request->input('call');
        $data->userEmail = 'admin@admin.com';


        if ($request->file('image')) {
            $file = $request->file('image');
            $filename = date('YmdHi') . $file->getClientOriginalName();
            $path = public_path('images/' . $filename);

            $manager = new ImageManager(new Driver());

            $image = $manager->read($file->getRealPath());

            // Resize width to max 1200px (you can change this), maintain aspect ratio
    $image->resize(200, 200, function ($constraint) {
                $constraint->aspectRatio();
                $constraint->upsize(); // prevent upsizing smaller images
            });
            // Save the compressed image (quality from 0–100)
            $image->save($path, 70); // 70% quality to reduce size

            $data['image'] = $filename;
        }
        $data->save();
        return redirect('/accomindation');
    }


    public function deleteAccomindation($id)
    {

        $data = Accomindation::where('id', '=', $id)->first();
        $data->delete();
        return redirect('/accomindation');
    }





    public function guide()
    {
        if (Session::get('email') != null)
            return view('studentGuide');
        else
            return redirect('/login');
    }











    public function forum()
    {
        if (Session::get('email') != null)
            return view('studentForum');
        else
            return redirect('/login');
    }
    public function business()
    {
        if (Session::get('email') != null) {
            $pendingUsers = User::where('type', '=', 'Local Business')->where('status', '=', 0)->get();
            $acceptedUsers  = User::where('type', '=', 'Local Business')->where('status', '=', 1)->get();
            $rejectedUsers  = User::where('type', '=', 'Local Business')->where('status', '=', 2)->get();
            return view('localBusiness', compact('pendingUsers', 'acceptedUsers', 'rejectedUsers'));
        } else
            return redirect('/login');
    }


    public function acceptBusiness($id)
    {
        $user = User::where('id', '=', $id)->first();
        $user->status = 1;
        $user->update();
        return redirect('/business');
    }

    public function rejectBusiness($id)
    {
        $user = User::where('id', '=', $id)->first();
        $user->status = 2;
        $user->update();
        return redirect('/business');
    }


    public function users()
    {
        if (Session::get('email') != null) {
            $users = User::where('type', '=', 'Student')->get();
            return view('userAccount')->with('users', $users);
        } else
            return redirect('/login');
    }


    public function deleteUser($id)
    {
        $user = User::where('id', '=', $id)->first();
        $user->delete();
        return redirect('/users');
    }


    public function reports()
    {
        if (Session::get('email') != null) {

            $usersDays = User::selectRaw('Day(created_at) as date')
                ->groupByRaw('Day(created_at)')
                ->pluck('date');

            $usersCounts = User::select(DB::raw("COUNT(*) as count"))
                ->groupByRaw('Day(created_at)')
                ->pluck('count');

            $accomindationsDays = Accomindation::selectRaw('Day(created_at) as date')
                ->groupByRaw('Day(created_at)')
                ->pluck('date');

            $accomindationsCounts = Accomindation::select(DB::raw("COUNT(*) as count"))
                ->groupByRaw('Day(created_at)')
                ->pluck('count');

            $jobsDays = Job::selectRaw('Day(created_at) as date')
                ->groupByRaw('Day(created_at)')
                ->pluck('date');

            $jobsCounts = Job::select(DB::raw("COUNT(*) as count"))
                ->groupByRaw('Day(created_at)')
                ->pluck('count');

            $offerDays = Offer::selectRaw('Day(created_at) as date')
                ->groupByRaw('Day(created_at)')
                ->pluck('date');

            $offerCounts = Offer::select(DB::raw("COUNT(*) as count"))
                ->groupByRaw('Day(created_at)')
                ->pluck('count');

            $transportsDays = Transport::selectRaw('Day(created_at) as date')
                ->groupByRaw('Day(created_at)')
                ->pluck('date');

            $transportsCounts = Transport::select(DB::raw("COUNT(*) as count"))
                ->groupByRaw('Day(created_at)')
                ->pluck('count');


            return view('reports', compact('usersDays', 'usersCounts', 'accomindationsDays', 'accomindationsCounts', 'jobsDays', 'jobsCounts', 'offerDays', 'offerCounts', 'transportsDays', 'transportsCounts'));
        } else
            return redirect('/login');
    }
}
