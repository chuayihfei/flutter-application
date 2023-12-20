using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;

public class VideoPlayCollision : MonoBehaviour
{
    [SerializeField]
    private GameObject videoObject;

    private void OnTriggerEnter(Collider collider)
    {
        //if collider detects collision with player
        if(collider.gameObject.name == "indicator")
        {
            videoObject.SetActive(true);

            videoObject.GetComponent<VideoPlayer>().errorReceived += delegate (VideoPlayer videoplayer, string message)
            {
                Debug.LogWarning("[VideoPlayer] Play Video Error: " + message);
            };
        }
    }

    public void PausePlay()
    {
        if(videoObject.GetComponent<VideoPlayer>().isPlaying)
        {
            videoObject.GetComponent<VideoPlayer>().Pause();
        }
        else
        {
            videoObject.GetComponent<VideoPlayer>().Play();
        }
    }
}
