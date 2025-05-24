<?php

namespace App\Http\Controllers;

use App\Models\Transport;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class TransportController extends Controller
{
    public function transport()
    {
        if(Session::get('email') != null){
            $transports = Transport::all();
            return view('transportation')->with("transports" , $transports);
        }

        else
            return redirect('/login');
    }

    public function addTransport(){
        if(Session::get('email') != null)
            return view('addTransport');
        else
            return redirect('/login');
    }

    public function addTransportProcess(Request $request){
        $data= new Transport();
        $data->name = $request->input('name');
        $data->description = $request->input('description');
       
        $data->cost = $request->input('cost');
        $data->distance= $request->input('distance');
        $data->type = $request->input('type');
       
        $data->availability = $request->input('availability');
        $data->userEmail = 'admin@admin.com';
       
        $data->save();
        return redirect('/transport');
    }

    public function editTransport($id){
        if(Session::get('email') != null){
            $transport = Transport::where('id' , '=' , $id)->first();
            return view('addTransport')->with('transport' , $transport);
        }
        else
            return redirect('/login');
    }

    public function editTransportProcess(Request $request){
        $data= Transport::where('id' , '=' , $request->input('id'))->first();
       
        $data->name = $request->input('name');
        $data->description = $request->input('description');
       
        $data->cost = $request->input('cost');
        $data->distance= $request->input('distance');
        $data->type = $request->input('type');
       
        $data->availability = $request->input('availability');
        $data->userEmail = 'admin@admin.com';


        $data->update();
        return redirect('/transport');
 
    }

    public function deleteTransport($id){
       
        $data = Transport::where('id' , '=' , $id)->first();
        $data->delete();
        return redirect('/transport');
    }
}
