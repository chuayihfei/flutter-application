using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Networking;
using System;

public class GPSMapDisplay : MonoBehaviour
{
    public string apiKey;
    public float lat = 0;
    public float lon = 0;
    public int zoom = 20;

    public enum mapResolution {  low = 1, high = 2  };
    public mapResolution mapReso = mapResolution.low;

    public enum mapType { roadmap, satellite, gybrid, terrain};
    public mapType mapDisplayType = mapType.roadmap;

    private string url = "";
    private int mapWidth = 640;
    private int mapHeight = 640;
    private bool mapLoading = false;
    private Rect rect;
    private string apiKeyLast;

    private float latLast = 0;
    private float lonLast = 0;
    private int zoomLast = 20;
    private mapResolution mapResoLast = mapResolution.low;
    private mapType mapDisplayTypeLast = mapType.roadmap;
    private bool updateMap = true;

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(GetGoogleMapsImage());
        rect = gameObject.GetComponent<RawImage>().rectTransform.rect;
        mapWidth = (int)Math.Round(rect.width);
        mapHeight = (int)Math.Round(rect.height);
    }

    // Update is called once per frame
    void Update()
    {
        if(updateMap && (apiKeyLast != apiKey || !Mathf.Approximately(latLast, lat) ||
            !Mathf.Approximately(lonLast, lon) || zoomLast != zoom || mapResoLast != mapReso || mapDisplayTypeLast != mapDisplayType))
        {
            rect = gameObject.GetComponent<RawImage>().rectTransform.rect;
            mapWidth = (int)Math.Round(rect.width);
            mapHeight = (int)Math.Round(rect.height);
            StartCoroutine(GetGoogleMapsImage());
            updateMap = false;

        }
    }

    IEnumerator GetGoogleMapsImage()
    {
        url = "https://maps.googleapis.com/maps/api/staticmap?center=" + lat + "%2C" + lon + "&zoom=" + zoom + "&size=" + mapWidth + "x" + mapHeight 
            +"&markers=color:red%7Clabel:S%" + "%7C" + lat + "%2C" + lon + "&markers=size:mid%7C"
            +"&markers=color:red%7Clabel:G%" + "%7C" + 1.349148784556591 + "%2C" + 103.8729569012672 + "&markers=size:mid%7C"
            + "&scale=" + mapReso + "&maptype=" + mapDisplayType + "&key=" + apiKey;

        mapLoading = true;
        UnityWebRequest www = UnityWebRequestTexture.GetTexture(url);
        yield return www.SendWebRequest();

        if(www.result != UnityWebRequest.Result.Success)
        {
            Debug.LogError("WWW Error: " + www.error);
        }
        else
        {
            mapLoading = false;

            //change texture
            //gameObject.GetComponent<RawImage>().texture = ((DownloadHandlerTexture)www.downloadHandler).texture;

            apiKeyLast = apiKey;
            latLast = lat;
            lonLast = lon;
            zoomLast = zoom;
            mapResoLast = mapReso;
            mapDisplayTypeLast = mapDisplayType;
            updateMap = true;

            //Debug.Log("Url generated: " + url);
        }
    }

    public void OpenMaps()
    {
        //StartCoroutine(OpenInGoogleMaps());

        url = "https://www.google.com/maps/dir/?api=1&origin=" + lat + "%2C" + lon
            + "&destination=" + 1.349148784556591 + "%2C" + 103.8729569012672
            + "&travelmode=walking";

        Application.OpenURL(url);
        Debug.Log("Opening app on Google Maps");
    }

    /*IEnumerator OpenInGoogleMaps()
    {
        url = "https://www.google.com/maps/dir/?api=1&origin=" + lat + "%2C" + lon
            + "&destination=" + 1.3485970729736205 + "%2C" + 103.87297567673242
            + "&travelmode=walking";

        UnityWebRequest www = UnityWebRequest.Get(url);
        yield return www.SendWebRequest();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.LogError("WWW Error: " + www.error);
        }
        else
        {
            Debug.Log("Opening app on Google Maps");
        }
    }*/
}
