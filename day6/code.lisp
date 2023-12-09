(defun find-possible-times (time record)
  (reduce #'+ 
          (mapcar (lambda (i) (is-new-record time i record)) 
                  (loop for i from 1 to time collect i))))

(defun is-new-record (time i record)
  (if (> (* (- time i) i) record)
      1
      0))

(defun main ()
  (let ((times #(value1 value2 value3 value4))  
        (records #(value1 value2 value3 value4))))  
        (time2 value)
        (record2 value))

    (format t "Answer1: ~D~%" 
            (reduce #'* 
                    (mapcar #'find-possible-times (coerce times 'list) (coerce records 'list))))

    (format t "Answer2: ~D~%" (find-possible-times time2 record2))))

(main)
