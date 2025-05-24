<?php

namespace App\Http\Controllers;

use App\Models\Contact;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class ContactController extends Controller
{
    public function contacts()
    {
        if(Session::get('email') != null){
            
            $contacts = Contact::all();
            return view('contacts')->with('contacts' , $contacts);
        }
        else
            return redirect('/login');
    }
    public function addContacts(){
        if(Session::get('email') != null){
            
            return view('addContacts');
        }
        else
            return redirect('/login');
    }
    public function addContactsProcess(Request $request){
        $name = $request->input('name');
        $phone = $request->input('phone');
        $email = $request->input('email');
        
        $contact = new Contact();
        $contact->name = $name;
        $contact->phone = $phone;
        $contact->email = $email;
        $contact->save();
        return redirect('/contacts');
    }


    public function editContacts($id){
        if(Session::get('email') != null){
            $contact = Contact::where('id' , '=' , $id)->first();
            return view('addContacts')->with('contact' , $contact);
        }
        else
            return redirect('/login');
    }

    public function editContactProcess(Request $request){
        $data= Contact::where('id' , '=' , $request->input('id'))->first();
       
        $data->name = $request->input('name');
        $data->phone = $request->input('phone');
       
        $data->email = $request->input('email');
      


        $data->update();
        return redirect('/contacts');
 
    }

    public function deleteContacts($id){
       
        $data = Contact::where('id' , '=' , $id)->first();
        $data->delete();
        return redirect('/contacts');
    }
}
