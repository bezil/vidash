defmodule VidashLiveServerWeb.MemberJSON do
    alias VidashLiveServer.Members.Member

    @doc """
    Renders a list of members.
    """
    def showlist(%{members: members}) do
      %{members: for(member <- members, do: data(member))}
    end

    @doc """
    Renders a single member.
    """
    def show(%{member: member}) do
      %{details: data(member)}
    end

    defp data(%Member{} = member) do
      %{
        id: member.id,
        role: member.role,
      }
    end
  end
