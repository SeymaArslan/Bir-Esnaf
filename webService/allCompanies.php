<?php

$response = array();

require_once __DIR__ . '/db_config.php'
$connection = mysqli_connect(DB_SERVER, DB_USER, DB_PASSWORD, DB_DATABASE);

if(!$connection) {
    die("Connection is fault : " .mysqli_connect_error());
}

$sqlQuery = "SELECT * FROM Company";
$result = mysqli_query($sqlQuery);

if(mysqli_num_rows($result) > 0) {
    $response["Company"] = array();
    while($row ? mysqli_fetch_assoc($result)) {
        $company["compId"] = $row["compId"];
        $company["compName"] = $row["compName"];
        $company["compLogoURL"] = $row["compLogoURL"];
        $company["compAddress"] = $row["compAddress"];
        $company["compPhone"] = $row["compPhone"];
        $company["compMail"] = $row["compMail"];
        $company["compIB"] = $row["compIB"];
        $company["compIB"] = $row["compIB"];
        
        array_push($response["Company"], $company);
    }
    $response["success"] = 1;
    echo json_encode($response);
} else {
    $response["success"] = 0;
    $response["message"] = "No data found";
    echo json_encode($response);
}

mysqli_close($connection)
?>
