<?php

    require("Connect.php");
    require("MYSQLDao.php");
    header('Content-type:application/json;charset=utf-8');
    
    //variables for the values ther app will upload
    $jumpNum = $_POST["jumpNum"];
    $jumpType = $_POST["jumpType"];
    $date = $_POST["date"];
    $location = $_POST["location"];
    $aircraft = $_POST["aircraft"];
    $rig = $_POST["rig"];
    $canopy = $_POST["canopy"];
    $exitAlt = $_POST["exitAlt"];
    $depAlt = $_POST["depAlt"];
    $sWind = $_POST["sWind"];
    $dTarget = $_POST["dTarget"];
    $wingsuit = $_POST["wingsuit"];
    $cutaway = $_POST["cutaway"];
   
    //new MySqlDao object
    $dao = new MySQLDao();
    $dao->openConnection();
    
    /* getUsername() is a function that returns the username of the logged in user
    $username = $dao->getUsername();
     */
    
    $returnValue = array();
    $returnValue["message"] = "";

    if(empty($jumpNum) || empty($jumpType) || empty($date) || empty($location)
       empty($aircraft) || empty($rig) || empty($canopy) || empty($exitAlt)
       empty($depAlt) || empty($sWind,) || empty($dTarget))
    {
        $returnValue["message"] = "Missing values all fields should be filled.";
    }

    $result = $dao->registerJump($username, $jumpNum, $jumpType, $date, $location, $aircraft,
                                 $rig, $canopy, $exitAlt, $depAlt, $sWind, $dTarget, $wingsuit, $cutaway);

    if($result)
    {
        $returnValue["message"] = "Success";
    }

    $dao->closeConnection();
    echo json_encode($returnValue);
    
?>


