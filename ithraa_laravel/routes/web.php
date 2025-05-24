<?php

use App\Http\Controllers\ContactController;
use App\Http\Controllers\PolicyController;
use App\Http\Controllers\TransportController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/


Route::get('/', [UserController::class, 'index']);

Route::get('/accomindation', [UserController::class, 'accomindation']);

Route::get('/addaccomindation', [UserController::class, 'addAccomindation']);
Route::post('/addaccomindation', [UserController::class, 'addAccomindationProcess']);

Route::get('/editaccomindation/{id}', [UserController::class, 'editAccomindation']);
Route::post('/editaccomindation', [UserController::class, 'editAccomindationProcess']);

Route::get('/deleteaccomindation/{id}', [UserController::class, 'deleteAccomindation']);


Route::get('/transport', [TransportController::class, 'transport']);

Route::get('/addtransport', [TransportController::class, 'addTransport']);
Route::post('/addtransport', [TransportController::class, 'addTransportProcess']);

Route::get('/edittransport/{id}', [TransportController::class, 'editTransport']);
Route::post('/edittransport', [TransportController::class, 'editTransportProcess']);

Route::get('/deletetransport/{id}', [TransportController::class, 'deleteTransport']);





Route::get('/guide', [UserController::class, 'guide']);


Route::get('/policy' , [PolicyController::class, 'policy']);
Route::post('/addpolicy' , [PolicyController::class, 'addPolicy']);
Route::post('/addpolicyitem' , [PolicyController::class, 'addPolicyItem']);


Route::get('/contacts' , [ContactController::class, 'contacts']);
Route::get('/addcontacts' , [ContactController::class, 'addContacts']);
Route::post('/addcontacts' , [ContactController::class, 'addContactsProcess']);

Route::get('/editcontacts/{id}', [ContactController::class, 'editContacts']);
Route::post('/editcontacts', [ContactController::class, 'editContactProcess']);
Route::get('/deletecontacts/{id}', [ContactController::class, 'deleteContacts']);


Route::get('/forum', [UserController::class, 'forum']);

Route::get('/business', [UserController::class, 'business']);
Route::get('/acceptBusiness/{id}', [UserController::class, 'acceptBusiness']);
Route::get('/rejectBusiness/{id}', [UserController::class, 'rejectBusiness']);

Route::get('/users', [UserController::class, 'users']);
Route::get('/deleteStudent/{id}', [UserController::class, 'deleteUser']);



Route::get('/reports', [UserController::class, 'reports']);

Route::get('/login', [UserController::class, 'login']);
Route::post('/login', [UserController::class, 'loginProcess']);
