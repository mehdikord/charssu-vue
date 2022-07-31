<?php

namespace App\Http\Middleware;

use App\Models\Serviceman;
use Closure;
use Illuminate\Http\Request;

class ApiServicemanAuth
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        if (Serviceman::whereNotNull('api_token')->where('api_token',$request->header('Authorization'))->exists()){
            return $next($request);
        }
        return response("Unauthorized",401);
    }
}
