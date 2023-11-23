using System.Collections;
using UnityEngine;
using UnityEngine.AI;

public class NavigationManager : MonoBehaviour
{
    [SerializeField]
    private GameObject navTargetObj;

    public Vector3 TargetPosition { get; set; } = Vector3.zero;

    public NavMeshPath CalculatedPath { get; private set; }

    // Start is called before the first frame update
    void Start()
    {
        CalculatedPath = new NavMeshPath();
    }

    // Update is called once per frame
    void Update()
    {
        //new target position
        if(TargetPosition != Vector3.zero)
        {
            NavMesh.CalculatePath(transform.position, TargetPosition,
                NavMesh.AllAreas, CalculatedPath);

            //move target object to new position
            navTargetObj.transform.position = TargetPosition;
        }
    }
}
