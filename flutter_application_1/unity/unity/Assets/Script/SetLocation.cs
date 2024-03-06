using System.Collections;
using System.Collections.Generic;
using Unity.XR.CoreUtils;
using UnityEngine;

public class SetLocation : MonoBehaviour
{
    [SerializeField]
    private NavigationManager navigationManager;

    [SerializeField]
    private XROrigin arOrigin;

    private TargetHandler targetHandler;

    private string defaultStart = "19";
    private string defaultDestination = "5";

    IEnumerator Start()
    {
        targetHandler = FindAnyObjectByType<TargetHandler>();
        yield return new WaitForEndOfFrame();

        //set default start and end destinations
        SetStartPoint(defaultStart);
        //SetDestinationPoint(defaultDestination);
    }

    public void SetStartPoint(string startName)
    {
        //find value and index in db?
        int index;
        int.TryParse(startName, out index);
        SetDropdownStartPos(index);
        SetDropdownStartRot(index);

        Debug.Log("[log] Setting start point: " + targetHandler.currentTargetList[index].Name);
    }

    public void SetDestinationPoint(string destinationName)
    {
        int index;
        int.TryParse(destinationName, out index);

        SetDropdownDestinationPos(index);

        Debug.Log("[log] Setting destination point: " + targetHandler.currentTargetList[index].Name);
    }
    public void SetDropdownDestinationPos(int selectedValue)
    {
        navigationManager.TargetPosition = GetSelectedTargetPos(selectedValue);
    }

    public void SetDropdownStartPos(int selectedValue)
    {
        arOrigin.transform.position = GetSelectedTargetPos(selectedValue);
    }
    public void SetDropdownStartRot(int selectedValue)
    {
        arOrigin.transform.rotation = Quaternion.Euler(
            GetSelectedTargetRot(selectedValue));
    }

    private Vector3 GetSelectedTargetPos(int selectedValue)
    {
        if (selectedValue >= targetHandler.currentTargetList.Count)
        {
            return Vector3.zero;
        }

        return targetHandler.currentTargetList[selectedValue].Position;
    }

    private Vector3 GetSelectedTargetRot(int selectedValue)
    {
        if (selectedValue >= targetHandler.currentTargetList.Count)
        {
            return Vector3.zero;
        }

        return targetHandler.currentTargetList[selectedValue].Rotation;
    }
}
