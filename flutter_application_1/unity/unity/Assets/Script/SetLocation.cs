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

    IEnumerator Start()
    {
        targetHandler = FindAnyObjectByType<TargetHandler>();
        yield return new WaitForEndOfFrame();
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
