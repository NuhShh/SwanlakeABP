<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
    use HasFactory;
    
    protected $primaryKey = 'reviewID';
    protected $fillable = [
        'productName',
        'productType',
        'reviewTitle',
        'cardDesc',
        'processor',
        'processorDesc',
        'ram',
        'ramDesc',
        'storage',
        'storageDesc',
        'display',
        'displayDesc',
        'battery',
        'batteryDesc',
        'camera',
        'cameraDesc',
        'price',
        'reviewText',
        'imageName',
        'rating',
        'keyFeatures',
        'performance',
        'date',
        'reviewAccountID',
    ];
}
