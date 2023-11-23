using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using Unity.XR.CoreUtils;
using UnityEngine;

public class TargetHandler : MonoBehaviour
{
    [SerializeField]
    private TextAsset targetModelData;

    [SerializeField]
    private TMP_Dropdown destinationDropdown;

    [SerializeField]
    private TMP_Dropdown startDropdown;

    //For other scripts to access list of targets
    public List<Target> currentTargetList = new List<Target>();

    //Start is called before the first frame update
    void Start()
    {
        GenerateTargetItems();
        FillDropdowns();
    }

    //private void OnEnable()
    //{
    //    GenerateTargetItems();
    //    FillDropdowns();
    //}

    private void GenerateTargetItems()
    {
        IEnumerable<Target> targets = GenerateTargetFromJson();
        foreach(Target target in targets)
        {
            currentTargetList.Add(target);
        }
    }

    private IEnumerable<Target> GenerateTargetFromJson()
    {
        return JsonUtility.FromJson<TargetsWrapper>(targetModelData.text).listTargets;
    }

    private void FillDropdowns()
    {
        List<TMP_Dropdown.OptionData> targetData = currentTargetList.Select(
            x => new TMP_Dropdown.OptionData
        {
            text = $"{x.Name}"
        }).ToList();

        destinationDropdown.ClearOptions();
        destinationDropdown.AddOptions(targetData);

        startDropdown.ClearOptions();
        startDropdown.AddOptions(targetData);
    }

    private void OnDisable()
    {
        currentTargetList.Clear();
    }
}
