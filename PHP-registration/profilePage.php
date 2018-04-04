<?php
    
    require("Connect.php");
    require("MYSQLDao.php");
    header('Content-type:application/json;charset=utf-8');
    
    //new MySqlDao object
    $dao = new MySQLDao();
    $dao->openConnection();
    
    //variables for the values
    $username = $_POST["username"];
    $profileDetails = $dao->getProfileDetails($username);
    
    //if profileDetails is empty display error message
    if(empty($profileDetails))
    {
        $returnValue["status"] = "Error:";
        $returnValue["message"] = "We apologize something went wrong on our end.";
    }
    
    //close connection
    $dao->closeConnection();
    echo json_encode($returnValue);
    
    ?>



