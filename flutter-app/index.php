<?php
include 'serverDATA.php';
try {

    $connection = new PDO("mysql:host=localhost;dbname=flutter-app;charset=utf8", "root", "");

} catch (PDOException $e) {
    exit("ارتباط با دیتا بیس برقرار نشد ");

}
sleep(2);

$server_data = new serverDATA($connection);


if (isset($_GET['action'])) {
    $metod_name =
        $_GET['action'];
    if (method_exists($server_data, $metod_name)) {

        $server_data->$metod_name($_GET);


    }

}

