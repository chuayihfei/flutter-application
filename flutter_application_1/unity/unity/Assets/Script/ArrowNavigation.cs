using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.UIElements;

public class ArrowNavigation : MonoBehaviour
{
    [SerializeField]
    private GameObject arrowObj;

    [SerializeField]
    private NavigationManager navigationManager;

    [SerializeField]
    private Slider navigationYOffset;

    [SerializeField]
    private float moveOnDistance;

    private NavMeshPath path;
    private float currDistance;
    private Vector3[] pathAndOffset;
    private Vector3 nextNavigationPoint = Vector3.zero;


    // Update is called once per frame
    void Update()
    {
        path = navigationManager.CalculatedPath;

        AddOffsetToPath();
        NextNavivationPoint();
        AddArrowOffset();

        arrowObj.transform.LookAt(nextNavigationPoint);
    }

    private void AddOffsetToPath()
    {
        pathAndOffset = new Vector3[path.corners.Length];
        for (int i = 0; i < path.corners.Length; i++)
        {
            pathAndOffset[i] = new Vector3(path.corners[i].x, transform.position.y,
                path.corners[i].z);
        }

    }

    private void NextNavivationPoint()
    {
        nextNavigationPoint = NextNavivationPointInDistance();
    }

    private Vector3 NextNavivationPointInDistance()
    {
        for (int i = 0; i < pathAndOffset.Length; i++)
        {
            currDistance = Vector3.Distance(transform.position, pathAndOffset[i]);
            if(currDistance > moveOnDistance)
            {
                return pathAndOffset[i];
            }
        }
        return navigationManager.TargetPosition;
    }

    private void AddArrowOffset()
    {
        if(navigationYOffset.value != 0)
        {
            arrowObj.transform.position = new Vector3(arrowObj.transform.position.x,
                navigationYOffset.value, arrowObj.transform.position.z);
        }    
    }
}
