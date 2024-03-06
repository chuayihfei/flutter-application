using FlutterUnityIntegration;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerObjCollision : MonoBehaviour
{
    [SerializeField]
    private GameObject objectToActive;

    [SerializeField]
    private NavigationManager navigationManager;

    private UnityMessageManager Manager
    {
        get { return GetComponent<UnityMessageManager>(); }
    }

    private void OnTriggerEnter(Collider collider)
    {
        if(name == "DestinationAreaCube")
        {
            navigationManager.ReachedDest = true;
        }

        //if collider with player
        if(collider.gameObject.name == "indicator")
        {
            objectToActive.SetActive(true);

            Manager.SendMessage(name);
        }
    }
}
