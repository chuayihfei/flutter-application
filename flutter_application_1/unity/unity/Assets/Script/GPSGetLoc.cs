using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Android;

public class GPSGetLoc : MonoBehaviour
{

    // Start is called before the first frame update
    void Start()
    {
        CheckLocPerms();
    }

    // Update is called once per frame
    void Update()
    {
        GetUserLoc();
    }

    public void CheckLocPerms()
    {
        if (!Input.location.isEnabledByUser)
        {
            Debug.LogWarning("No Location Permission");
            Permission.RequestUserPermission(Permission.FineLocation);
        }
        else
        {
            Debug.Log("Location Permission Granted");
        }
    }

    public void GetUserLoc()
    {
        //check if user gave perms for location
        if(Input.location.isEnabledByUser)
        {
            Debug.Log("Location Permission Granted");
            //StartCoroutine(GetLatLonGPS());
        }
    }

    IEnumerator GetLatLonGPS()
    {
        Input.location.Start();

        int maxWaitTime = 5;

        while (Input.location.status == LocationServiceStatus.Initializing && maxWaitTime > 0)
        {
            // wait for location to initialize
            yield return new WaitForSeconds(1);
            maxWaitTime--;
        }

        Debug.Log("Wait before getting lat and long");

        //get location value
        double longitude = Input.location.lastData.longitude;
        double latitude = Input.location.lastData.latitude;

        //add current location
        Debug.Log(Input.location.status + " lat: " + latitude + "long: "+ longitude);

        //stop retrieving data
        Input.location.Stop();
        StopCoroutine("Start");
    }
}
