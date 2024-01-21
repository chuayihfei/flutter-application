using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerObjCollision : MonoBehaviour
{
    [SerializeField]
    private GameObject objectToActive;

    private void OnTriggerEnter(Collider collider)
    {
        //if collider with player
        if(collider.gameObject.name == "indicator")
        {
            objectToActive.SetActive(true);
        }
    }
}
