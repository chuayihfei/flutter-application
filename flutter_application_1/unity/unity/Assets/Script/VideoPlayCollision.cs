using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VideoPlayCollision : MonoBehaviour
{
    [SerializeField]
    private GameObject videoObject;

    private void OnTriggerEnter(Collider collider)
    {
        if(collider.gameObject.name == "indicator")
        {
            videoObject.SetActive(true);
        }
    }
}
