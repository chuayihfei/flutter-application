using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class SetUIText : MonoBehaviour
{
    [SerializeField]
    private TMP_Text textField;
    [SerializeField]
    private string fixedText;

    public void OnSliderValueChange(float numericValue)
    {
        textField.text = $"{fixedText}: {numericValue}";
    }
}
