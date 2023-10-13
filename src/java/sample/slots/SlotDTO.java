
package sample.slots;

import java.io.Serializable;
import java.sql.Time;

public class SlotDTO implements Serializable{
    private String slotID;
    private String day1;
    private String day2;
    private String startTime;
    private String endTime;

    public SlotDTO() {
        this.slotID = "";
        this.day1 = "";
        this.day2 = "";
        this.startTime = "";
        this.endTime = "";
    }

    public SlotDTO(String slotID, String day1, String day2, String startTime, String endTime) {
        this.slotID = slotID;
        this.day1 = day1;
        this.day2 = day2;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    

    /**
     * @return the slotID
     */
    public String getSlotID() {
        return slotID;
    }

    /**
     * @param slotID the slotID to set
     */
    public void setSlotID(String slotID) {
        this.slotID = slotID;
    }

    /**
     * @return the day1
     */
    public String getDay1() {
        return day1;
    }

    /**
     * @param day1 the day1 to set
     */
    public void setDay1(String day1) {
        this.day1 = day1;
    }

    /**
     * @return the day2
     */
    public String getDay2() {
        return day2;
    }

    /**
     * @param day2 the day2 to set
     */
    public void setDay2(String day2) {
        this.day2 = day2;
    }

    /**
     * @return the startTime
     */
    public String getStartTime() {
        return startTime;
    }

    /**
     * @param startTime the startTime to set
     */
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /**
     * @return the endTime
     */
    public String getEndTime() {
        return endTime;
    }

    /**
     * @param endTime the endTime to set
     */
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    
}
