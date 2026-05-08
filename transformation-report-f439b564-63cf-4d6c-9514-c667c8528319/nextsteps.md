# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the migration or pre-existing issues.

### 6. Check for Platform-Specific Code

Search the codebase for any APIs that were available in .NET Framework but have limited or no support in cross-platform .NET, such as:

- `System.Web` references
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side components
- `AppDomain.CreateDomain`
- `BinaryFormatter`

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to assist with identifying these areas.

### 7. Review Configuration Files

Ensure that any configuration previously held in `Web.config` or `App.config` has been properly migrated to `appsettings.json` or `appsettings.{Environment}.json`. Verify that connection strings, application settings, and environment-specific values are all present and correctly formatted.

### 8. Verify Static Files and Middleware

If this is an ASP.NET Core web application, confirm that the `Program.cs` or `Startup.cs` file includes the necessary middleware registrations, such as:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
```

### 9. Deploy to Target Environment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target server or hosting environment and verify the application starts and runs correctly in that environment.