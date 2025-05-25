<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    use HasFactory;

    protected $primaryKey = 'commentID';
    protected $fillable = [
        'commentText',
        'commentAccountID',
        'commentReviewID',
        'commentUsername',
    ];
}
