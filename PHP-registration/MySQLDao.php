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

        //creates the information to be displayed by the profile
        public function getProfileDetails($username) {
            $returnValue = array();
            
            $tJumps = getTotalJumps($username);
            $tSport = getTotalSportJumps($username);
            $tBase = getTotalBaseJumps($username);
            $tTandem = getTotalTandemJumps($username);
            $tStudent = getTotalStudentJumps($username);
            $tCutaway = getTotalCutaway($username);
            $tWingsuit = getTotalWingsuit($username);
            $tFFD = getTotalFFD($username);
            $tFFT = getTotalFFT($username);
        }
        
        //gets Total Jumps
        public function getTotalJumps($username) {
            $sql = "SELECT MAX(jumpNum) FROM jumpLog WHERE username = '".$username."'";
            $result = $this->conn->query($sql);
            return $result;
        }
        //gets Total Sport Jumps
        public function getTotalSportJumps($username) {
            $sql = "SELECT COUNT(jumpType) FROM jumpLog WHERE jumpType = Sport AND username = '".$username."'";
            $result = $this->conn->query($sql);
            return $result;
        }
        //gets Total B.A.S.E Jumps
        public function getTotalBaseJumps($username) {
            $sql = "SELECT COUNT(jumpType) FROM jumpLog WHERE jumpType = B.A.S.E AND username = '".$username."'";
            $result = $this->conn->query($sql);
            return $result;
        }
        //gets Total Tandem Jumps
        public function getTotalTandemJumps($username) {
            $sql = "SELECT COUNT(jumpType) FROM jumpLog WHERE jumpType = Tandem AND username = '".$username."'";
            $result = $this->conn->query($sql);
            return $result;
        }
        //gets Total Student Jumps
        public function getTotalStudentJumps($username) {
            $sql = "SELECT COUNT(jumpType) FROM jumpLog WHERE jumpType = Student AND username = '".$username."'";
            $result = $this->conn->query($sql);
            return $result;
        }
        //gets Total Cutaways
        public function getTotalCutaway($username) {
            $sql = "SELECT COUNT(cutaway) FROM jumpLog WHERE cutaway = yes AND username = '".$username."'";
            $result = $this->conn->query($sql);
            return $result;
        }
        //gets Total Wingsuit
        public function getTotalWingsuit($username) {
            $sql = "SELECT COUNT(wingsuit) FROM jumpLog WHERE wingsuit = yes AND username = '".$username."'";
            $result = $this->conn->query($sql);
            return $result;
        }
        //gets Total Free Fall Distance
        public function getTotalFFD($username) {
            $sql1 = "SELECT SUM(exitAlt) FROM jumpLog WHERE username = '".$username."'";
            $sql2 = "SELECT SUM(depAlt) FROM jumpLog WHERE username = '".$username."'";
            $result1 = $this->conn->query($sql1);
            $result2 = $this->conn->query($sql2);
            return ($result1 - $result2);
        }
        //get Total Free Fall Time
        // 12 sec for the first 1000 feet then 6 sec for every 1000 feet after
        public function getTotalFFT($username) {
            $FFD = getTotalFFD($username);
            $totalRJ = getTotalRJ($username);
            //handles the first 1000 feet
            $fTime = $totalRJ * 12;
            $FFD = $FFD - ($totalRJ * 1000)
            //handles the remaining 1000 feet
            $result = $fTime + (($FFD / 1000) * 6)
            return $result
        }
        //get Total Registered Jumps
        public function getTotalRJ($username) {
            $sql = "SELECT COUNT(jumpNum) FROM jumpLog WHERE username = '".$username."'";
            $result = $this->conn->query($sql);
            return $result;
        }
        
    }

?>


