using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.UI;

public class LineNavigation : MonoBehaviour
{
    [SerializeField]
    private NavigationManager navigationManager;

    [SerializeField]
    private LineRenderer line;
    
    [SerializeField]
    private Slider lineYOffset;

    private NavMeshPath path;
    private Vector3[] calculatedPathAndOffset;


    // Update is called once per frame
    void Update()
    {
        path = navigationManager.CalculatedPath;
        AddOffsetToPath();
        AddLineOffset();
        SetLineRendererPosition();
    }

    private void AddOffsetToPath()
    {
        calculatedPathAndOffset = new Vector3[path.corners.Length];

        //get offset between cam and first point on floor
        float offset = Mathf.Abs(transform.position.y - path.corners[0].y);

        for (int i = 0; i < path.corners.Length; i++)
        {
            calculatedPathAndOffset[i] = new Vector3(path.corners[i].x, path.corners[i].y + offset,
                path.corners[i].z);
        }

    }

    private void AddLineOffset()
    {
        if(lineYOffset.value != 0)
        {
            for(int i=0; i<calculatedPathAndOffset.Length; i++)
            {
                calculatedPathAndOffset[i] += new Vector3(0, lineYOffset.value, 0);
            }
        }
    }

    private void SetLineRendererPosition()
    {
        line.positionCount = calculatedPathAndOffset.Length;
        line.SetPositions(calculatedPathAndOffset);
    }
}
