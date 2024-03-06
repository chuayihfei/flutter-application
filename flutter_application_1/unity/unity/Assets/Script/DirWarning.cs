using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.AI;
using Unity.XR.CoreUtils;

public class DirWarning : MonoBehaviour
{
    [SerializeField]
    private NavigationManager navigationManager;

    [SerializeField]
    private TMP_Text displayWarningText;

    [SerializeField]
    private XROrigin arOrigin;

    private NavMeshPath path;

    void Update()
    {
        path = navigationManager.CalculatedPath;
        float angle = getAngle();

        if (angle > 40.0f)
        {
            displayWarningText.text = "Turn left";
        }
        else if (angle < -40.0f)
        {
            displayWarningText.text = "Turn right";
        }
        else
            displayWarningText.text = "";
    }

    private float getAngle()
    {
        float angle = 0.0f;
        if (!navigationManager.ReachedDest)
        {
            angle = Vector3.Angle(path.corners[1] - arOrigin.Camera.transform.position, arOrigin.Camera.transform.forward);

            //for debugging, draws lines
            //Debug.DrawLine(arOrigin.transform.position, path.corners[1], Color.blue);
            //Debug.DrawRay(arOrigin.transform.position, arOrigin.Camera.transform.forward, Color.red);

            Vector3 delta = (path.corners[1] - arOrigin.Camera.transform.position).normalized;
            Vector3 cross = Vector3.Cross(delta, arOrigin.Camera.transform.forward);

            //determine left or right, if less, then is right
            if (cross.y < 0)
            {
                angle *= -1;
            }
        }

        return angle;
    }
}
