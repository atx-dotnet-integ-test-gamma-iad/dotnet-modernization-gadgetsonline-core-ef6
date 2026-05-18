# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to your intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider upgrading to the latest stable release of .NET.

### 4. Run Unit Tests

If the solution contains test projects, execute all tests to verify that existing functionality has not been broken during transformation:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures before proceeding.

### 5. Check for Removed or Replaced APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently in cross-platform .NET. Review the following areas manually:

- **HTTP and networking**: Ensure any usage of `HttpWebRequest`, `WebClient`, or similar types has been reviewed or replaced with `HttpClient`.
- **Configuration**: Verify that `System.Configuration.ConfigurationManager` usage has been replaced with `Microsoft.Extensions.Configuration` if applicable.
- **Database access**: If Entity Framework is used, confirm the project is using Entity Framework Core and that migrations are compatible.
- **File system paths**: Ensure paths use `Path.Combine` and do not rely on Windows-specific path separators.

### 6. Run the Application Locally

Start the application locally and perform manual smoke testing of core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the primary workflows of the application and confirm expected behavior.

### 7. Verify Runtime on Target Platform

If the intended deployment target is Linux or macOS, run the application on that platform explicitly to surface any remaining platform-specific issues that would not appear on Windows.

### 8. Publish the Application

Once validation is complete, publish the application using the following command, replacing the runtime identifier as appropriate for your target environment:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --runtime linux-x64 --self-contained false --output ./publish
```

Review the contents of the `./publish` directory and deploy them to your target environment according to your hosting setup (e.g., IIS, Kestrel behind a reverse proxy such as Nginx or Apache).