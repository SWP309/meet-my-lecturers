/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.freeslots;

/**
 *
 * @author W10
 */
public class FreeSlotError {

    private String pastTimeError;
    private String endTimeError;
    private String durationError;
    private String capacityError;
    private String meetLinkError;
    private String repeatedTimeError;
    private String duplicateTimeError;

    public FreeSlotError() {
        this.pastTimeError = "";
        this.endTimeError = "";
        this.durationError = "";
        this.capacityError = "";
        this.meetLinkError = "";
        this.repeatedTimeError = "";
        this.duplicateTimeError = "";
    }

    public FreeSlotError(String pastTimeError, String endTimeError, String durationError, String capacityError, String meetLinkError, String repeatedTimeError, String duplicateTimeError) {
        this.pastTimeError = pastTimeError;
        this.endTimeError = endTimeError;
        this.durationError = durationError;
        this.capacityError = capacityError;
        this.meetLinkError = meetLinkError;
        this.repeatedTimeError = repeatedTimeError;
        this.duplicateTimeError = duplicateTimeError;
    }

    public String getPastTimeError() {
        return pastTimeError;
    }

    public void setPastTimeError(String pastTimeError) {
        this.pastTimeError = pastTimeError;
    }

    public String getEndTimeError() {
        return endTimeError;
    }

    public void setEndTimeError(String endTimeError) {
        this.endTimeError = endTimeError;
    }

    public String getDurationError() {
        return durationError;
    }

    public void setDurationError(String durationError) {
        this.durationError = durationError;
    }

    public String getCapacityError() {
        return capacityError;
    }

    public void setCapacityError(String capacityError) {
        this.capacityError = capacityError;
    }

    public String getMeetLinkError() {
        return meetLinkError;
    }

    public void setMeetLinkError(String meetLinkError) {
        this.meetLinkError = meetLinkError;
    }

    public String getRepeatedTimeError() {
        return repeatedTimeError;
    }

    public void setRepeatedTimeError(String repeatedTimeError) {
        this.repeatedTimeError = repeatedTimeError;
    }

    public String getDuplicateTimeError() {
        return duplicateTimeError;
    }

    public void setDuplicateTimeError(String duplicateTimeError) {
        this.duplicateTimeError = duplicateTimeError;
    }

}
