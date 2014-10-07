;;; Copyright (c) 2014, Georg Bartels <georg.bartels@cs.uni-bremen.de>
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are met:
;;;
;;; * Redistributions of source code must retain the above copyright
;;; notice, this list of conditions and the following disclaimer.
;;; * Redistributions in binary form must reproduce the above copyright
;;; notice, this list of conditions and the following disclaimer in the
;;; documentation and/or other materials provided with the distribution.
;;; * Neither the name of the Institute for Artificial Intelligence/
;;; Universitaet Bremen nor the names of its contributors may be used to 
;;; endorse or promote products derived from this software without specific 
;;; prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
;;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;;; POSSIBILITY OF SUCH DAMAGE.

(in-package :cram-wsg50)

(defclass wsg50-interface ()
  ((move-client :initarg :move-client :accessor move-client :type service-client
                 :documentation "For internal use. ROS service client to command the
                 gripper to move its fingers --not expecting impact.")
   (grasp-client :initarg :grasp-client :accessor grasp-client :type service-client
                 :documentation "For internal use. ROS service client to command the
                 gripper to close its fingers for grasping --expecting impact.")
   (homing-client :initarg :homing-client :accessor homing-client :type service-client
                  :documentation "For internal use. ROS service client to home the gripper.")
   (status-subscriber :accessor status-subscriber :type subscriber
                      :documentation "For internal use. ROS topic subscriber to status
                      topic of gripper.")
   (acceleration-client :initarg :acceleration-client :accessor acceleration-client
                        :type service-client
                        :documentation "For internal use. ROS service client to set the max
                        acceleration employed by the gripper.")
   (force-client :initarg :force-client :accessor force-client :type service-client
                 :documentation "For internal use. ROS service client to set the max force
                 employed by the gripper.")
   (stop-client :initarg :stop-client :accessor stop-client :type service-client
                :documentation "For internal use. ROS service client to stop motions.")
   (ack-client :initarg :ack-client :accessor ack-client :type service-client
               :documentation "For internal use. ROS service client to acknowledge error.")
   (status :accessor status :type wsg50-status
           :documentation "For internal use. Last reported status of gripper.")
   (command-lock :initform (make-mutex :name (string (gensym "WSG50-COMMAND-LOCK-")))
                 :accessor command-lock :type mutex
                 :documentation "For internal use. Mutex to guard commanding WSG50 gripper
                 to ensure one command at a time.")
   (status-lock :initform (make-mutex :name (string (gensym "WSG50-STATUS-LOCK-")))
                 :accessor status-lock :type mutex
                 :documentation "For internal use. Mutex to guard update of status of WSG50
                 gripper to ensure consistent i/o."))
  (:documentation "For internal use. ROS Interface talking to Schunk WSG50 gripper controller."))

(defclass wsg50-status ()
  ((width :initarg :width :reader width :type number
          :documentation "For internal use. Width opening of Schunk WSG50 gripper.")
   (max-acc :initarg :max-acc :reader max-acc :type number
            :documentation "For internal use. Maximum acceleration setting of Schunk WSG50 gripper.")
   (max-force :initarg :max-force :reader max-force :type number
              :documentation "For internal use. Maximum force setting of Schunk WSG50 gripper."))
  (:documentation "For internal use. Gripper status of Schunk WSG50."))