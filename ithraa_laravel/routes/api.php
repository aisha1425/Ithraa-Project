<?php

use App\Models\Accomindation;
use App\Models\baba;
use App\Models\Contact;
use App\Models\customer;
use App\Models\Job;
use App\Models\Offer;
use App\Models\Policy;
use App\Models\Transport;
use App\Models\User;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/



Route::post('/login', function (Request $request) {
    $email = $request->input("email");
    $password = $request->input("password");


    $user = User::where('email', '=', $email)->where('password', '=', $password)->first();

    if ($user) {
        return Response::json(
            $user,
            200
        );
    } else {
        return Response::json(
            ['error' => 'User does not exist'],
            404
        );
    }
});



Route::post('/signup', function (Request $request) {

     try {

    $user = new User();

    $user->username = $request->input("username") ?? '';
    $user->email = $request->input("email");
    $user->phone = $request->input("phone") ?? '';
    $user->businessType = $request->input("businessType") ?? '';

    $user->major = $request->input("major") ?? '';
    $user->universityLocation = $request->input("universityLocation") ?? '';
    $user->date = $request->input("date") ?? '';
    $user->type = $request->input("type") ?? '';
    $user->regNumber = $request->input("regNumber") ?? '';
    $user->location = $request->input("location") ?? '';
    $user->contact = $request->input("contact") ?? '';
    $user->website = $request->input("website") ?? '';

    $user->password = $request->input("password");

    $user->image = '';
    $user->regFile = '';

    if ($request->hasFile('image')) {

        $file = $request->file('image');
        $filename = date('YmdHi') . $file->getClientOriginalName();
        $path = public_path('images/' . $filename);
        
$manager = new ImageManager(new Driver());

            $image = $manager->read($file->getRealPath());

            // Resize width to max 1200px (you can change this), maintain aspect ratio
            $image->resize(1200, null, function ($constraint) {
                $constraint->aspectRatio();
                $constraint->upsize(); // prevent upsizing smaller images
            });

            // Save the compressed image (quality from 0–100)
            $image->save($path, 70); // 70% quality to reduce size
        $user->image = $filename;
    }

    if ($request->hasFile('commerceFile')) {

        $file = $request->file('commerceFile');
        $filename = date('YmdHi') . $file->getClientOriginalName();
        $file->move(public_path('images'), $filename);
        $user->regFile = $filename;
    }

    if ($user->save()) {
        $user->status = 0;
        return Response::json($user, 200);
    } else {
        return response()->json(['error' => 'Entered data is incorrect'], 404);
    }

     } catch (QueryException $e) {
       
        return response()->json(['error' => 'Entered data is incorrect'], 404);
        
    } catch (\Exception $e) {
    
        return response()->json(['error' => 'Entered data is incorrect'], 404);
    }
});


Route::post('/updateProfile', function (Request $request) {

    $user = User::where('email', '=', $request->input('email'))->first();

    if ($request->input('username') != null)
        $user->username =  $request->input("username");

    if ($request->input('phone') != null)
        $user->phone = $request->input("phone");
    if ($request->input('businessType') != null)
        $user->businessType = $request->input("businessType");

    if ($request->input('major') != null)
        $user->major = $request->input("major");

    if ($request->input('universityLocation') != null)
        $user->universityLocation = $request->input('universityLocation');
    if ($request->input('date') != null)
        $user->date = $request->input("date");

    if ($request->input('regNumber') != null)
        $user->regNumber = $request->input("regNumber");
    if ($request->input('location') != null)
        $user->location = $request->input("location");
    if ($request->input('contact') != null)
        $user->contact = $request->input("contact");
    if ($request->input('website') != null)
        $user->website = $request->input("website");
    
    if ($request->input('password') != null)
        $user->password = $request->input("password");

    if ($request->hasFile('commerceFile')) {

        $file = $request->file('commerceFile');
        $filename = date('YmdHi') . $file->getClientOriginalName();
        $file->move(public_path('images'), $filename);
        $user->regFile = $filename;
    }

    if ($request->hasFile('image')) {

        $file = $request->file('image');
        $filename = date('YmdHi') . $file->getClientOriginalName();
        $file->move(public_path('images'), $filename);
        $user->image = $filename;
    }

    if ($user->update()) {
        return Response::json(
            $user,
            200
        );
    } else {

        return Response::json(
            ['error' => 'Server Timed Out'],
            404
        );
    }
});


Route::post('/profile', function (Request $request) {
    $email = $request->email;
    $user = User::where('email', '=', $email)->first();
    if ($user) {

        return Response::json(
            $user,
            200
        );
    } else {
        return Response::json(
            ['error' => 'No Data'],
            404
        );
    }
});


Route::post('/getAllAccomindation', function (Request $request) {
    $accomindations = Accomindation::all();
    if ($request->input('userEmail') != '') {
        $accomindations = Accomindation::where('userEmail', '=', $request->input('userEmail'))->get();
    }
    if ($accomindations) {
        return Response::json(
            $accomindations,
            200
        );
    } else {

        return Response::json(
            ['error' => 'No Data'],
            404
        );
    }
});


Route::post('/transport', function (Request $request) {
    $email = $request->input('userEmail');
    $transports = Transport::all();
    if ($email != null) {
        $transports = Transport::where('userEmail', '=', $email)->get();
    }
    if ($transports) {
        return Response::json(
            $transports,
            200
        );
    } else {

        return Response::json(
            ['error' => 'No Data'],
            404
        );
    }
});

Route::post('/policies', function () {
    $policies = Policy::all();
    if ($policies) {

        return Response::json(
            $policies,
            200
        );
    } else {
        return Response::json(
            ['error' => 'No Data'],
            404
        );
    }
});



Route::post('/contacts', function () {
    $contacts = Contact::all();
    if ($contacts) {

        return Response::json(
            $contacts,
            200
        );
    } else {
        return Response::json(
            ['error' => 'No Data'],
            404
        );
    }
});



Route::post('/jobs', function (Request $request) {
    $jobs = Job::all();
    if ($request->input('userEmail') != '') {
        $jobs = Job::where('userEmail', '=', $request->input('userEmail'))->get();
    }


    foreach ($jobs as $job) {
        $user = User::where('email', '=', $job->userEmail)->first();
        $job->company = $user->username;
    }


    if ($jobs) {

        return Response::json(
            $jobs,
            200
        );
    } else {
        return Response::json(
            ['error' => 'No Data'],
            404
        );
    }
});




Route::post('/addJob', function (Request $request) {

    $job = new Job();

    $job->title = $request->input("title") ?? '';
    $job->description = $request->input("description") ?? '';
    $job->location = $request->input("location") ?? '';
    $job->salary = $request->input("salary") ?? '';
    $job->type = $request->input("type") ?? '';
    $job->deadline = $request->input("deadline") ?? '';
    $job->userEmail = $request->input("userEmail") ?? '';

    if ($job->save()) {
        return Response::json($job, 200);
    } else {
        return Response::json(['error' => 'Could not save job'], 500);
    }
});

Route::post('/editJob', function (Request $request) {
    $id = $request->input('id');

    $job = Job::where('id' , '=' , $id)->first();

    $job->title = $request->input("title") ?? '';
    $job->description = $request->input("description") ?? '';
    $job->location = $request->input("location") ?? '';
    $job->salary = $request->input("salary") ?? '';
    $job->deadline = $request->input("deadline") ?? '';
    $job->userEmail = $request->input("userEmail") ?? '';

    if ($job->update()) {
        return Response::json($job, 200);
    } else {
        return Response::json(['error' => 'Could not save job'], 500);
    }
});


Route::post('/deleteJob', function (Request $request) {
    $id = $request->input('id');
    $data = Job::where('id', '=', $id)->first();

    if ($data->delete()) {
        return Response::json($data, 200);
    } else {
        return Response::json(['error' => 'Could not Delete Accomindation'], 500);
    }
});

Route::post('/offers', function (Request $request) {
    $offers = Offer::all();
    if ($request->input('userEmail') != '') {
        $offers = Offer::where('userEmail', '=', $request->input('userEmail'))->get();
    }


    foreach ($offers as $offer) {
        $user = User::where('email', '=', $offer->userEmail)->first();
        $offer->company = $user->username;
    }


    if ($offers) {

        return Response::json(
            $offers,
            200
        );
    } else {
        return Response::json(
            ['error' => 'No Data'],
            404
        );
    }
});

Route::post('/addOffer', function (Request $request) {

    $offer = new Offer();

    $offer->title = $request->input("title") ?? '';
    $offer->description = $request->input("description") ?? '';
    $offer->discount = $request->input("discount") ?? '';
    $offer->link = $request->input("link") ?? '';
    $offer->date = $request->input("date") ?? '';
    $offer->userEmail = $request->input("userEmail") ?? '';
    $offer->image = '';

    if ($request->hasFile('imageFile')) {
        $file = $request->file('imageFile');
        $filename = date('YmdHi') . $file->getClientOriginalName();
        $path = public_path('images/' . $filename);
        
$manager = new ImageManager(new Driver());

            $image = $manager->read($file->getRealPath());

            // Resize width to max 1200px (you can change this), maintain aspect ratio
            $image->resize(1200, null, function ($constraint) {
                $constraint->aspectRatio();
                $constraint->upsize(); // prevent upsizing smaller images
            });

            // Save the compressed image (quality from 0–100)
            $image->save($path, 70); // 70% quality to reduce size
        $offer->image = $filename;
    }

    if ($offer->save()) {
        return Response::json($offer, 200);
    } else {
        return Response::json(['error' => 'Could not save Offer'], 500);
    }
});


Route::post('/editOffer', function (Request $request) {
    $id = $request->input('id');
    $offer = Offer::where('id' , '=' , $id)->first();

    $offer->title = $request->input("title") ?? '';
    $offer->description = $request->input("description") ?? '';
    $offer->discount = $request->input("discount") ?? '';
    $offer->link = $request->input("link") ?? '';
    $offer->date = $request->input("date") ?? '';
    $offer->userEmail = $request->input("userEmail") ?? '';
    $offer->image = $request->input('image') ?? '';

    if ($request->hasFile('imageFile')) {
        $file = $request->file('imageFile');
        $filename = date('YmdHi') . $file->getClientOriginalName();
        $path = public_path('images/' . $filename);
        
$manager = new ImageManager(new Driver());

            $image = $manager->read($file->getRealPath());

            // Resize width to max 1200px (you can change this), maintain aspect ratio
            $image->resize(1200, null, function ($constraint) {
                $constraint->aspectRatio();
                $constraint->upsize(); // prevent upsizing smaller images
            });

            // Save the compressed image (quality from 0–100)
            $image->save($path, 70); // 70% quality to reduce size
        $offer->image = $filename;
    }

    if ($offer->update()) {
        return Response::json($offer, 200);
    } else {
        return Response::json(['error' => 'Could not save Offer'], 500);
    }
});

Route::post('/deleteOffer', function (Request $request) {
    $id = $request->input('id');
    $data = Offer::where('id', '=', $id)->first();

    if ($data->delete()) {
        return Response::json($data, 200);
    } else {
        return Response::json(['error' => 'Could not Delete Accomindation'], 500);
    }
});


Route::post('/addAccomindation', function (Request $request) {

    $item = new Accomindation();

    $item->name = $request->input("name") ?? '';
    $item->description = $request->input("description") ?? '';
    $item->location = $request->input("location") ?? '';
    $item->price = $request->input("price") ?? '';
    $item->distance = $request->input("distance") ?? '';
    $item->type = $request->input("type") ?? '';
    $item->kitchen = $request->input("kitchen") ?? '';
    $item->laundary = $request->input("laundary") ?? '';
    $item->parking = $request->input("parking") ?? '';
    $item->bedrooms = $request->input("bedrooms") ?? '';
    $item->bathrooms = $request->input("bathrooms") ?? '';
    $item->internet = $request->input("internet") ?? '';
    $item->call = $request->input("call") ?? '';
    $item->userEmail = $request->input("userEmail") ?? '';
    $item->image = '';

    if ($request->hasFile('imageFile')) {
        $file = $request->file('imageFile');

        $filename = date('YmdHi') . $file->getClientOriginalName();
        $path = public_path('images/' . $filename);

        $manager = new ImageManager(new Driver());

            $image = $manager->read($file->getRealPath());

            $image->resize(200, 200, function ($constraint) {
                $constraint->aspectRatio();
                $constraint->upsize(); // prevent upsizing smaller images
            });
            // Save the compressed image (quality from 0–100)
            $image->save($path, 70); // 70% quality to reduce size

        $item->image = $filename;
    }

    if ($item->save()) {
        return response()->json($item, 200);
    } else {
        return response()->json(['error' => 'Could not save Accomindation'], 500);
    }
});


Route::post('/editAccomindation', function (Request $request) {
    $id = $request->input('id');


    $item = Accomindation::where('id', '=', $id)->first();

    $item->name = $request->input("name") ?? '';
    $item->description = $request->input("description") ?? '';
    $item->location = $request->input("location") ?? '';
    $item->price = $request->input("price") ?? '';
    $item->distance = $request->input("distance") ?? '';
    $item->type = $request->input("type") ?? '';
    $item->kitchen = $request->input("kitchen") ?? '';
    $item->laundary = $request->input("laundary") ?? '';
    $item->parking = $request->input("parking") ?? '';
    $item->bedrooms = $request->input("bedrooms") ?? '';
    $item->bathrooms = $request->input("bathrooms") ?? '';
    $item->internet = $request->input("internet") ?? '';
    $item->call = $request->input("call") ?? '';
    $item->userEmail = $request->input("userEmail") ?? '';
    $item->image = $request->input('image') ?? '';

    if ($request->hasFile('imageFile')) {

        $file = $request->file('imageFile');
        $filename = date('YmdHi') . $file->getClientOriginalName();
        $path = public_path('images/' . $filename);
        
$manager = new ImageManager(new Driver());

            $image = $manager->read($file->getRealPath());

           $image->resize(200, 200, function ($constraint) {
                $constraint->aspectRatio();
                $constraint->upsize(); // prevent upsizing smaller images
            });
            // Save the compressed image (quality from 0–100)
            $image->save($path, 70); // 70% quality to reduce size

        $item->image = $filename;
    }

    if ($item->update()) {
        return Response::json($item, 200);
    } else {
        return Response::json(['error' => 'Could not save Accomindation'], 500);
    }
});


Route::post('/deleteAccomindation', function (Request $request) {
    $id = $request->input('id');
    $data = Accomindation::where('id', '=', $id)->first();

    if ($data->delete()) {
        return Response::json($data, 200);
    } else {
        return Response::json(['error' => 'Could not Delete Accomindation'], 500);
    }
});

Route::post('/addTransport', function (Request $request) {


    $item = new Transport();

    $item->name = $request->input("name") ?? '';
    $item->description = $request->input("description") ?? '';
    $item->cost = $request->input("cost") ?? '';
    $item->availability = $request->input("availability") ?? '';
    $item->distance = $request->input("distance") ?? '';
    $item->type = $request->input("type") ?? '';
    $item->userEmail = $request->input("userEmail") ?? '';

    if ($item->save()) {
        return Response::json($item, 200);
    } else {
        return Response::json(['error' => 'Could not save Accomindation'], 500);
    }
});


Route::post('/editTransport', function (Request $request) {
    $id = $request->input('id');


    $item = Transport::where('id', '=', $id)->first();

    $item->name = $request->input("name") ?? '';
    $item->description = $request->input("description") ?? '';
    $item->cost = $request->input("cost") ?? '';
    $item->availability = $request->input("availability") ?? '';
    $item->distance = $request->input("distance") ?? '';
    $item->type = $request->input("type") ?? '';
    $item->userEmail = $request->input("userEmail") ?? '';

    if ($item->update()) {
        return Response::json($item, 200);
    } else {
        return Response::json(['error' => 'Could not save Accomindation'], 500);
    }
});



Route::post('/deleteTransport', function (Request $request) {
    $id = $request->input('id');
    $data = Transport::where('id', '=', $id)->first();

    if ($data->delete()) {
        return Response::json($data, 200);
    } else {
        return Response::json(['error' => 'Could not Delete Accomindation'], 500);
    }
});


Route::post('/loadCounts' , function(Request $request) {
    $email = $request->input('email');
    $jobs = Job::where('userEmail' , '=' , $email)->get();
    $jobsCount = sizeof($jobs);


    $offers = Offer::where('userEmail' , '=' , $email)->get();
    $offersCount = sizeof($offers);


    $accomindations = Accomindation::where('userEmail' , '=' , $email)->get();
    $accomindationsCount = sizeof($accomindations);


    $transports = Transport::where('userEmail' , '=' , $email)->get();
    $transportsCount = sizeof($transports);

    $allcounts = [
        $jobsCount,
        $offersCount,
        $accomindationsCount,
        $transportsCount
    ];

    return Response::json($allcounts, 200);
});


Route::get('/images/{filename}', function ($filename) {
    $path = public_path('images/' . $filename);

    if (!File::exists($path)) {
        abort(404);
    }

    $file = File::get($path);
    $type = File::mimeType($path);

    return response($file, 200)
        ->header("Content-Type", $type)
        ->header("Connection" , 'Keep-alive')
        ->header("Content-Length", filesize($path));
});