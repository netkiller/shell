<?php

$m = new MongoClient('mongodb://localhost');

$db = $m->test;

$collection = $db->article;

$document = array( "title" => "Linux", "author" => "" );
$collection->insert($document);

$document = array( "title" => "FreeBSD", "online" => true );
$collection->insert($document);

$cursor = $collection->find();

foreach ($cursor as $document) {
    echo $document["title"] . "\n";
}

?> 
