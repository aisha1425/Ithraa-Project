<?php

namespace App\Http\Controllers;

use App\Models\Policy;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class PolicyController extends Controller
{
    public function policy()
    {
        if (Session::get('email') != null) {
            $policies = Policy::all();
            return view('policy')->with('policies', $policies);
        } else
            return redirect('/login');
    }




    public function addPolicy(Request $request)
    {
        $name = $request->input('policy');
        $policy = new Policy();
        $policy->name = $name;
        $policy->details = '';
        $policy->save();
        return redirect('/policy');
    }

    public function addPolicyItem(Request $request)
    {
        $id = $request->input('id');
        $policy = Policy::where("id", "=", $id)->first();

        if ($request->file('item')) {
            $file = $request->file('item');
            $filename = date('YmdHi') . $file->getClientOriginalName();
            $file->move(public_path('images'), $filename);

            $policy->details = $filename;
        }
        $policy->update();
        return redirect('/policy');
    }
}
