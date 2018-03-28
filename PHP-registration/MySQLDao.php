<?php

    class MySQLDao {
    //PHP file that contains all the queries
        var $dbhost = null;
        var $dbuser = null;
        var $dbpass = null;
        var $conn = null;
        var $dbname = null;
        var $result = null;
        
        //constructor initiliazes
        function __construct() {
            $this->dbhost = Connection::$dbhost;
            $this->dbuser = Connection::$dbuser;
            $this->dbpass = Connection::$dbpass;
            $this->dbname = Connection::$dbname;
        }
        //opens a connection with that database
        public function openConnection() {
            $this->conn = new mysqli($this->dbhost, $this->dbuser, $this->dbpass, $this->dbname);
            //if a connection error occurs print out error message
            if(mysqli_connect_errno()) {
                echo ("Error! Could not establish connection with database");
            }
        }
        //getter method for connection
        public function getConnection() {
            return $this->conn;
        }
        //method to close connection
        public function closeConnection() {
            if($this->conn != null) {
                $this->conn->close();
            }
        }
        //returns all of the users row information from the 'users' Table in the database
        //that match the username
        //-used for the registration to check if user already exists
        public function getUserDetails($username) {
            $returnValue = array();
            $sql = "SELECT * FROM users WHERE username = '".$username."'";
            $result = $this->conn->query($sql);
            
            if($result != null && (mysqli_num_rows($result) >= 1)) {
                $row = $result->fetch_array(MYSQLI_ASSOC);
                if(!empty($row)) {
                    $returnValue = $row;
                }
            }
            return $returnValue;
        }

        //creates a new row in the 'user' Table and adds the information
        public function registerUser($firstName, $lastName, $username, $password) {
            $sql = "INSERT INTO `users` (`username`, `pass`, `fname`, `lname`) VALUES ('$username', '$password', '$firstName', '$lastName')";
            $result = $this->conn->query($sql);
            return $result;
        }
        
        //creates a new row in the 'jumpLog' Table and adds the information
        public function registerJump($username, $jumpNum, $jumpType, $date, $location, $aircraft,
                                     $rig, $canopy, $exitAlt, $depAlt, $sWind, $dTarget, $wingsuit, $cutaway) {
            $sql = "INSERT INTO `jumpLog` (`username`, `jumpNum`, `jumpType`, `day`, `location`, `aircraft`, `rig`, `canopy`, `exitAlt`, `depAlt`, `sWind`, `dTarget`, `wingsuit`, `cutaway`) VALUES ('$username', '$jumpNum', '$jumpType', '$date', '$location', '$aircraft', '$rig', '$canopy', '$exitAlt', '$depAlt', '$sWind', '$dTarget', '$wingsuit', '$cutaway')";
            $result = $this->conn->query($sql);
            return $result;
        }
    }

?>


